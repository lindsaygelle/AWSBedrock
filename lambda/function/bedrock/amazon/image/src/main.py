from abc import ABC, abstractmethod
from http import HTTPStatus
from datetime import datetime
from typing import (
    Any,
    AnyStr,
    ByteString,
    Dict,
    List,
    Literal,
    Optional,
    TypedDict,
    Union,
)
import base64
import boto3
import botocore
import json
import hashlib
import os
import uuid


class BodyTextImage(TypedDict):
    imageGenerationConfig: Dict
    taskType: Literal["TEXT_IMAGE"]
    textToImageParams: Dict


class InvokeModelRequest(TypedDict):
    accept: Optional[str]
    body: Union[BodyTextImage]
    contentType: Optional[str]
    guardrailIdentifier: Optional[str]
    guardrailVersion: Optional[str]
    modelId: Optional[str]
    trace: Optional[str]


class InvokeModelResponseBody(TypedDict):
    error: str
    images: List[AnyStr]


class InvokeModelResponseMetaData(TypedDict):
    HTTPHeaders: Dict[str, Any]
    HTTPStatusCode: int
    RequestId: str
    RetryAttempts: int


class InvokeModelResponse(TypedDict):
    ResponseMetaData: InvokeModelResponseMetaData
    body: botocore.response.StreamingBody
    contentType: str


class PutObjectRequest(TypedDict):
    ACL: Literal[
        "authenticated-read",
        "aws-exec-read",
        "bucket-owner-full-control",
        "bucket-owner-read",
        "private",
        "public-read",
        "public-read-write",
    ]
    Body: Union[ByteString]
    Bucket: str
    BucketKeyEnabled: Optional[bool]
    CacheControl: Optional[str]
    ContentDisposition: Optional[str]
    ContentEncoding: Optional[str]
    ContentLanguage: Optional[str]
    ContentLength: Optional[int]
    ContentMD5: Optional[str]
    ContentType: Optional[str]
    ChecksumAlgorithm: Optional[Literal["CRC32", "CRC32C", "SHA1", "SHA256"]]
    ChecksumCRC32: Optional[str]
    ChecksumCRC32C: Optional[str]
    ChecksumSHA1: Optional[str]
    ChecksumSHA256: Optional[str]
    ExpectedBucketOwner: Optional[str]
    Expires: Optional[datetime]
    GrantFullControl: Optional[str]
    GrantRead: Optional[str]
    GrantReadACP: Optional[str]
    GrantWriteACP: Optional[str]
    Key: str
    Metadata: Optional[Dict[str, Any]]
    ServerSideEncryption: Optional[Literal["AES256", "aws:kms", "aws:kms:dsse"]]
    StorageClass: Optional[
        Literal[
            "DEEP_ARCHIVE",
            "EXPRESS_ONEZONE",
            "GLACIER",
            "GLACIER_IR",
            "INTELLIGENT_TIERING",
            "ONEZONE_IA",
            "OUTPOSTS",
            "REDUCED_REDUNDANCY",
            "SNOW",
            "STANDARD",
            "STANDARD_IA",
        ]
    ]
    SSECustomerAlgorithm: Optional[str]
    SSECustomerKey: Optional[str]
    SSEKMSEncryptionContext: Optional[str]
    SSEKMSKeyId: Optional[str]
    RequestPayer: Optional[Literal["requester"]]
    Tagging: Optional[str]
    ObjectLockLegalHoldStatus: Optional[Literal["OFF", "ON"]]
    ObjectLockMode: Optional[Literal["COMPLIANCE", "GOVERNANCE"]]
    ObjectLockRetainUntilDate: Optional[datetime]
    WebsiteRedirectLocation: Optional[str]


class EventBody(BodyTextImage):
    taskType: Literal["TEXT_IMAGE"]


class Event(TypedDict):
    body: EventBody
    guardrailIdentifier: Optional[str]
    guardrailVersion: Optional[str]
    modelId: str
    trace: Optional[Literal["DISABLED", "ENABLED"]]


class BedrockRuntime(ABC):
    @abstractmethod
    def invoke_model(
        body: ByteString,
        contentType: str,
        accept: str,
        modelId: str,
        trace: Optional[Literal["ENABLED", "DISABLED"]],
        guardrailIdentifier: Optional[str],
        guardrailVersion: Optional[str],
    ) -> InvokeModelResponse:
        raise NotImplementedError


class S3Client(ABC):
    @abstractmethod
    def put_object() -> None:
        raise NotImplementedError


bedrock_runtime_client: BedrockRuntime = boto3.client(service_name="bedrock-runtime")
s3_client = boto3.client("s3")


def main(event: Event, _):
    s3_bucket_acl = os.environ["S3_BUCKET_ACL"]
    s3_bucket_name = os.environ["S3_BUCKET_NAME"]
    invoke_model_request_model_id = event["body"].pop("modelId")
    invoke_model_request_task_type = event["body"]["taskType"]
    invoke_model_request: InvokeModelRequest = {
        "accept": "application/json",
        "body": json.dumps(event["body"]),
        "contentType": "application/json",
        "modelId": invoke_model_request_model_id,
    }
    if "trace" in event:
        invoke_model_request["trace"] = event["trace"]
    if "guardrailIdentifier" in event:
        invoke_model_request["guardrailIdentifier"] = event["guardrailIdentifier"]
    if "guardrailVersion" in event:
        invoke_model_request["guardrailVersion"] = event["guardrailVersion"]
    if "trace" in event:
        invoke_model_request["trace"] = event["trace"]

    invoke_model_response: InvokeModelResponse = bedrock_runtime_client.invoke_model(
        **invoke_model_request
    )
    response_body: InvokeModelResponseBody = json.loads(
        invoke_model_response.get("body").read()
    )
    for base64_image in response_body["images"]:

        put_object_request_body: bytes = base64.b64decode(base64_image)

        put_object_request_etag = hashlib.md5(put_object_request_body).hexdigest()

        put_object_request = PutObjectRequest(
            ACL=s3_bucket_acl,
            Body=put_object_request_body,
            Bucket=s3_bucket_name,
            ContentLanguage="en-US",
            ContentType="image/png",
            Key="modelId={}/taskType={}/{}.png".format(
                invoke_model_request_model_id,
                invoke_model_request_task_type,
                put_object_request_etag,
            ),
        )
        put_object_response = s3_client.put_object(**put_object_request)
        print(put_object_response)


if __name__ == "__main__":
    import random


    main(
        {
            "body": {
                "modelId": "amazon.titan-image-generator-v1",
                "taskType": "TEXT_IMAGE",
                "textToImageParams": {
                    "text": "A photograph of a cup of coffee from the side"
                },
                "imageGenerationConfig": {
                    "numberOfImages": 1,
                    "height": 512,
                    "width": 512,
                    "cfgScale": 8.0,
                    "seed": random.randrange(0, 200000),
                },
            },
        },
        None,
    )
