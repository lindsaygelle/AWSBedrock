from abc import ABC, abstractmethod
from base64 import b64decode
from boto3 import client
from botocore.exceptions import BotoCoreError
from botocore.response import StreamingBody
from datetime import datetime
from hashlib import md5
from http import HTTPStatus
from json import JSONDecodeError, dumps, loads
from os import environ
from typing import (
    AnyStr,
    ByteString,
    Dict,
    List,
    Literal,
    Optional,
    TypedDict,
    Union,
)

BedrockRuntimeTrace = Literal[
    "DISABLED",
    "ENABLED",
]


class AWSResponseMetadata(TypedDict):
    HTTPHeaders: Dict[str, str]
    HTTPStatusCode: int
    RequestId: str
    RetryAttempts: int


class AmazonTextImageimageGenerationConfig(TypedDict):
    cfgScale: float
    height: int
    numberOfImages: int
    seed: int
    width: int


class AmazonTextImagetextToImageParams(TypedDict):
    negativeText: Optional[str]
    text: str


class AmazonTextImage(TypedDict):
    imageGenerationConfig: AmazonTextImageimageGenerationConfig
    taskType: Literal["TEXT_IMAGE"]
    textToImageParams: AmazonTextImagetextToImageParams


class BedrockRuntimeInvokeModelResponseMetadata(AWSResponseMetadata):
    pass


class BedrockRuntimeInvokeModelResponseBody(TypedDict):
    images: List[AnyStr]


class BedrockRuntimeInvokeModelResponse(TypedDict):
    ResponseMetadata: AWSResponseMetadata
    body: StreamingBody
    contentType: str


class BedrockRuntimeInvokeModelRequest(TypedDict):
    accept: str
    body: ByteString
    contentType: str
    guardrailIdentifier: Optional[str]
    guardrailVersion: Optional[str]
    modelId: str
    trace: Optional[BedrockRuntimeTrace]


class BedrockRuntime(ABC):
    @abstractmethod
    def invoke_model(
        self,
        body: ByteString,
        contentType: str,
        accept: str,
        modelId: str,
        trace: Optional[BedrockRuntimeTrace],
        guardrailIdentifier: Optional[str],
        guardrailVersion: Optional[str],
    ) -> BedrockRuntimeInvokeModelResponse:
        raise NotImplementedError


class EventimageGenerationConfig(TypedDict):
    cfgScale: float
    height: int
    numberOfImages: int
    seed: int
    width: int


class EventtextToImageParams(TypedDict):
    negativeText: Optional[str]
    text: str


class Event(AmazonTextImage):
    guardrailIdentifier: Optional[str]
    guardrailVersion: Optional[str]
    modelId: Optional[Literal["amazon.titan-image-generator-v1"]]
    trace: Optional[BedrockRuntimeTrace]


S3ObjectACL = Literal[
    "authenticated-read",
    "aws-exec-read",
    "bucket-owner-full-control",
    "bucket-owner-read",
    "private",
    "public-read",
    "public-read-write",
]
S3ObjectChecksumAlgorithm = Literal["CRC32", "CRC32C", "SHA1", "SHA256"]
S3ObjectLockLegalHoldStatus = Literal["OFF", "ON"]
S3ObjectLockMode = Literal["COMPLIANCE", "GOVERNANCE"]
S3ObjectMetadata = Dict[str, str]
S3ObjectStorageClass = Literal[
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
S3ObjectServerSideEncryption = Literal["AES256", "aws:kms", "aws:kms:dsse"]


class S3HeadObjectRequest(TypedDict):
    Bucket: str
    ChecksumMode: Optional[Literal["ENABLED"]]
    ExpectedBucketOwner: Optional[str]
    IfMatch: Optional[str]
    IfModifiedSince: Optional[datetime]
    IfNoneMatch: Optional[str]
    IfUnmodifiedSince: Optional[datetime]
    Key: str
    PartNumber: Optional[int]
    Range: Optional[str]
    RequestPayer: Optional[Literal["requester"]]
    SSECustomerAlgorithm: Optional[str]
    SSECustomerKey: Optional[str]
    VersionId: Optional[str]


class S3HeadObjectResponseMetadata(AWSResponseMetadata):
    pass


class S3HeadObjectResponse(TypedDict):
    AcceptRanges: str
    ArchiveStatus: Literal["ARCHIVE_ACCESS", "DEEP_ARCHIVE_ACCESS"]
    BucketKeyEnabled: bool
    CacheControl: str
    ChecksumCRC32: str
    ChecksumCRC32C: str
    ChecksumSHA1: str
    ChecksumSHA256: str
    ContentDisposition: str
    ContentEncoding: str
    ContentLanguage: str
    ContentLength: int
    ContentType: str
    DeleteMarker: bool
    ETag: str
    Expiration: str
    Expires: datetime
    LastModified: datetime
    Metadata: Dict[str, str]
    MissingMeta: int
    ObjectLockLegalHoldStatus: S3ObjectLockLegalHoldStatus
    ObjectLockMode: S3ObjectLockMode
    ObjectLockRetainUntilDate: datetime
    PartsCount: int
    ReplicationStatus: Literal["COMPLETE", "PENDING", "FAILED", "REPLICA", "COMPLETED"]
    RequestCharged: str
    ResponseMetadata: S3HeadObjectResponseMetadata
    Restore: str
    SSECustomerAlgorithm: str
    SSECustomerKeyMD5: str
    SSEKMSKeyId: str
    ServerSideEncryption: S3ObjectServerSideEncryption
    StorageClass: S3ObjectStorageClass
    VersionId: str
    WebsiteRedirectLocation: str


class S3PutObjectRequest(TypedDict):
    ACL: Optional[S3ObjectACL]
    Body: Union[ByteString,]
    Bucket: str
    BucketKeyEnabled: Optional[bool]
    CacheControl: Optional[str]
    ChecksumAlgorithm: Optional[str]
    ChecksumCRC32: Optional[str]
    ChecksumCRC32C: Optional[str]
    ChecksumSHA1: Optional[str]
    ChecksumSHA256: Optional[str]
    ContentDisposition: Optional[str]
    ContentEncoding: Optional[str]
    ContentLanguage: Optional[str]
    ContentLength: Optional[str]
    ContentMD5: Optional[str]
    ContentType: Optional[str]
    ExpectedBucketOwner: Optional[str]
    Expires: Optional[str]
    GrantFullControl: Optional[str]
    GrantRead: Optional[str]
    GrantReadACP: Optional[str]
    GrantWriteACP: Optional[str]
    Key: Optional[str]
    Metadata: Optional[S3ObjectMetadata]
    ObjectLockLegalHoldStatus: Optional[S3ObjectLockLegalHoldStatus]
    ObjectLockMode: Optional[S3ObjectLockMode]
    ObjectLockRetainUntilDate: Optional[datetime]
    RequestPayer: Optional[str]
    SSECustomerAlgorithm: Optional[str]
    SSECustomerKey: Optional[str]
    SSEKMSEncryptionContext: Optional[str]
    SSEKMSKeyId: Optional[str]
    ServerSideEncryption: Optional[S3ObjectServerSideEncryption]
    StorageClass: Optional[S3ObjectStorageClass]
    Tagging: Optional[str]
    WebsiteRedirectLocation: Optional[str]


class S3PutObjectResponseMetadata(AWSResponseMetadata):
    pass


class S3PutObjectResponse(TypedDict):
    BucketKeyEnabled: bool
    ChecksumCRC32: Optional[str]
    ChecksumCRC32C: Optional[str]
    ChecksumSHA1: Optional[str]
    ChecksumSHA256: Optional[str]
    ETag: str
    Expiration: Optional[str]
    ResponseMetadata: S3PutObjectResponseMetadata
    RequestCharged: Optional[str]
    SSECustomerAlgorithm: Optional[str]
    SSECustomerKeyMD5: Optional[str]
    SSEKMSEncryptionContext: Optional[str]
    SSEKMSKeyId: Optional[str]
    ServerSideEncryption: S3ObjectServerSideEncryption
    VersionId: Optional[str]


class S3Client(ABC):
    @abstractmethod
    def head_object(
        self,
        Bucket: str,
        IfMatch: Optional[str],
        IfModifiedSince: Optional[datetime],
        IfNoneMatch: Optional[str],
        IfUnmodifiedSince: Optional[datetime],
        Key: str,
        Range: Optional[str],
        VersionId: Optional[str],
        SSECustomerAlgorithm: Optional[str],
        SSECustomerKey: Optional[str],
        RequestPayer: Optional[Literal["requester"]],
        PartNumber: Optional[int],
        ExpectedBucketOwner: Optional[str],
        ChecksumMode: Optional[Literal["ENABLED"]],
    ) -> S3HeadObjectResponse:
        raise NotImplementedError

    @abstractmethod
    def put_object(
        self,
        ACL: Optional[S3ObjectACL],
        Body: Union[ByteString,],
        Bucket: str,
        CacheControl: Optional[str],
        ContentDisposition: Optional[str],
        ContentEncoding: Optional[str],
        ContentLanguage: Optional[str],
        ContentLength: Optional[str],
        ContentMD5: Optional[str],
        ContentType: Optional[str],
        ChecksumAlgorithm: Optional[str],
        ChecksumCRC32: Optional[str],
        ChecksumCRC32C: Optional[str],
        ChecksumSHA1: Optional[str],
        ChecksumSHA256: Optional[str],
        Expires: Optional[str],
        GrantFullControl: Optional[str],
        GrantRead: Optional[str],
        GrantReadACP: Optional[str],
        GrantWriteACP: Optional[str],
        Key: Optional[str],
        Metadata: Optional[S3ObjectMetadata],
        ServerSideEncryption: Optional[S3ObjectServerSideEncryption],
        StorageClass: Optional[S3ObjectStorageClass],
        WebsiteRedirectLocation: Optional[str],
        SSECustomerAlgorithm: Optional[str],
        SSECustomerKey: Optional[str],
        SSEKMSKeyId: Optional[str],
        SSEKMSEncryptionContext: Optional[str],
        BucketKeyEnabled: Optional[bool],
        RequestPayer: Optional[str],
        Tagging: Optional[str],
        ObjectLockMode: Optional[S3ObjectLockMode],
        ObjectLockRetainUntilDate: Optional[datetime],
        ObjectLockLegalHoldStatus: Optional[S3ObjectLockLegalHoldStatus],
        ExpectedBucketOwner: Optional[str],
    ) -> S3PutObjectResponse:
        raise NotImplementedError


class LambdaRequest(TypedDict):
    pass


class LambdaResponseBodyS3Object(S3HeadObjectResponse):
    Bucket: str
    Key: str


LambdaResponseBodyS3Objects = List[any]


class LambdaResponseBody(TypedDict):
    S3Objects: LambdaResponseBodyS3Objects


class LambdaResponse(TypedDict):
    Body: Optional[Union[LambdaResponseBody, None]]
    ContentType: Optional[Union[Literal["application/json"], None]]
    StatusCode: int


bedrock_runtime: BedrockRuntime = client("bedrock-runtime")
s3_client: S3Client = client("s3")


def main(event: Event, _=None) -> LambdaResponse:

    if not isinstance(event, Dict):
        return LambdaResponse(
            Body=None,
            ContentType="application/json",
            StatusCode=HTTPStatus.BAD_REQUEST,
        )

    if not (
        ("imageGenerationConfig" in event)
        and (isinstance(event["imageGenerationConfig"], dict))
    ):
        return LambdaResponse(
            Body=None, ContentType="application/json", StatusCode=HTTPStatus.BAD_REQUEST
        )

    if not (
        ("textToImageParams" in event)
        and (isinstance(event["textToImageParams"], dict))
    ):
        return LambdaResponse(
            Body=None, ContentType="application/json", StatusCode=HTTPStatus.BAD_REQUEST
        )

    if ("negativeText" in event["textToImageParams"]) and (
        event["textToImageParams"]["negativeText"] is not None
    ):
        if len(event["textToImageParams"]["negativeText"]) < 3:
            del event["textToImageParams"]["negativeText"]

    if not (("modelId" in event) and (event["modelId"] is not None)):
        event["modelId"] = "amazon.titan-image-generator-v1"

    amazon_text_image: AmazonTextImage = AmazonTextImage(
        imageGenerationConfig=event["imageGenerationConfig"],
        taskType="TEXT_IMAGE",
        textToImageParams=event["textToImageParams"],
    )

    print(amazon_text_image)

    try:
        bedrock_invoke_model_request_body: str = dumps(amazon_text_image)
    except JSONDecodeError as e:
        raise e

    bedrock_invoke_model_request: BedrockRuntimeInvokeModelRequest = (
        BedrockRuntimeInvokeModelRequest(
            accept="application/json",
            body=bedrock_invoke_model_request_body,
            contentType="application/json",
            modelId=event["modelId"],
        )
    )

    if "guardrailIdentifier" in event:
        bedrock_invoke_model_request["guardrailIdentifier"] = event[
            "guardrailIdentifier"
        ]
    if "guardrailVersion" in event:
        bedrock_invoke_model_request["guardrailVersion"] = event["guardrailVersion"]
    if "trace" in event:
        bedrock_invoke_model_request["trace"] = event["trace"]

    print(bedrock_invoke_model_request)

    try:
        bedrock_invoke_model_response: BedrockRuntimeInvokeModelResponse = (
            bedrock_runtime.invoke_model(**bedrock_invoke_model_request)
        )
    except BotoCoreError as e:
        raise e

    bedrock_invoke_model_response_metadata: (
        BedrockRuntimeInvokeModelResponseMetadata
    ) = bedrock_invoke_model_response["ResponseMetadata"]

    if not (bedrock_invoke_model_response_metadata["HTTPStatusCode"] == HTTPStatus.OK):
        raise BotoCoreError()

    try:
        bedrock_invoke_model_response_body: BedrockRuntimeInvokeModelResponseBody = (
            loads(bedrock_invoke_model_response.get("body").read())
        )
    except JSONDecodeError as e:
        raise e

    if not "images" in bedrock_invoke_model_response_body:
        raise KeyError("images")

    lambda_response_body_s3_objects: LambdaResponseBodyS3Objects = []

    for base64_image in bedrock_invoke_model_response_body["images"]:

        decoded_image: bytes = b64decode(base64_image)

        s3_put_object_request: S3PutObjectRequest = S3PutObjectRequest(
            ACL=environ["S3_BUCKET_ACL"],
            Body=decoded_image,
            Bucket=environ["S3_BUCKET_NAME"],
            ContentLanguage="en-US",
            ContentType="image/png",
            Key="MODALITY=IMAGE/PROVIDER=AMAZON/MODEL={}/TASK=TEXT_IMAGE/{}.png".format(
                str.upper(event["modelId"]), md5(decoded_image).hexdigest()
            ),
        )

        print(s3_put_object_request)

        s3_put_object_response: S3PutObjectResponse = s3_client.put_object(
            **s3_put_object_request
        )

        print(s3_put_object_response)

        if not (
            s3_put_object_response["ResponseMetadata"]["HTTPStatusCode"]
            == HTTPStatus.OK
        ):
            continue

        s3_head_object_request: S3HeadObjectRequest = S3HeadObjectRequest(
            Bucket=s3_put_object_request["Bucket"], Key=s3_put_object_request["Key"]
        )

        print(s3_head_object_request)

        s3_head_object_response: S3HeadObjectResponse = s3_client.head_object(
            **s3_head_object_request
        )

        print(s3_head_object_response)

        lambda_response_body_s3_object: LambdaResponseBodyS3Object = (
            LambdaResponseBodyS3Object(
                Bucket=s3_head_object_request["Bucket"],
                Key=s3_head_object_request["Key"],
                **s3_head_object_response
            )
        )

        # TODO: Serialized response error with datetime.
        lambda_response_body_s3_object["LastModified"] = str(
            lambda_response_body_s3_object["LastModified"]
        )

        print(lambda_response_body_s3_object)

        lambda_response_body_s3_objects.append(lambda_response_body_s3_object)

    return LambdaResponse(
        Body=LambdaResponseBody(S3Objects=lambda_response_body_s3_objects),
        ContentType="application/json",
        StatusCode=HTTPStatus.OK,
    )
