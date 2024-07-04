from abc import ABC, abstractmethod
from base64 import b64decode
from boto3 import client
from botocore.response import StreamingBody
from datetime import datetime
from hashlib import md5
from http import HTTPStatus
from json import dumps, loads
from os import environ, path
from typing import ByteString, Dict, List, Literal, Optional, TypedDict

BedrockInvokeModelInputAccept = Literal["application/json"]
BedrockInvokeModelInputContentType = Literal["application/json"]
BedrockInvokeModelInputModelId = Literal["amazon.titan-image-generator-v1"]
BedrockInvokeModelInputTrace = Literal["DISABLED", "ENABLED"]
BedrockInvokeModelOutputContentType = Literal["application/json"]


class BedrockInvokeModelInput(TypedDict):
    accept: BedrockInvokeModelInputAccept
    body: ByteString
    contentType: BedrockInvokeModelInputContentType
    guardrailIdentifier: Optional[str]
    guardrailVersion: Optional[str]
    modelId: BedrockInvokeModelInputModelId
    trace: BedrockInvokeModelInputTrace


class BedrockInvokeModelOutput(TypedDict):
    body: StreamingBody
    contentType: BedrockInvokeModelOutputContentType


class TextImageInputImageGenerationConfig(TypedDict):
    cfgScale: float
    height: int
    numberOfImages: int
    seed: int
    width: int


class TextImageInputTextToImageParams(TypedDict):
    negativeText: str
    text: str


class TextImageInput(TypedDict):
    imageGenerationConfig: TextImageInputImageGenerationConfig
    taskType: Literal["TEXT_IMAGE"]
    textToImageParams: TextImageInputTextToImageParams


class TextImageOutput(TypedDict):
    error: Optional[str]
    images: List[ByteString]


class AbstractBedrockRuntime(ABC):
    @abstractmethod
    def invoke_model(
        self,
        body: ByteString,
        contentType: str,
        accept: str,
        modelId: str,
        trace: Optional[BedrockInvokeModelInputTrace],
        guardrailIdentifier: Optional[str],
        guardrailVersion: Optional[str],
    ) -> BedrockInvokeModelOutput:
        raise NotImplementedError


class BedrockRuntime:
    def invoke_model(
        self, bedrock_invoke_model_input: BedrockInvokeModelInput
    ) -> BedrockInvokeModelOutput:
        return self._client.invoke_model(**bedrock_invoke_model_input)

    def __init__(self, client: AbstractBedrockRuntime):
        self._client = client


S3ObjectACL = Literal[
    "authenticated-read",
    "aws-exec-read",
    "bucket-owner-full-control",
    "bucket-owner-read",
    "private",
    "public-read",
    "public-read-write",
]
S3ObjectArchieveStatus = Literal["ARCHIVE_ACCESS", "DEEP_ARCHIVE_ACCESS"]
S3ObjectChecksumAlgorithm = Literal["CRC32", "CRC32C", "SHA1", "SHA256"]
S3ObjectChecksumMode = Literal["ENABLED"]
S3ObjectLockLegalHoldStatus = Literal["OFF", "ON"]
S3ObjectLockMode = Literal["COMPLIANCE", "GOVERNANCE"]
S3ObjectReplicationStatus = Literal[
    "COMPLETE", "COMPLETED", "FAILED", "PENDING", "REPLICA"
]
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


class S3HeadObjectInput(TypedDict):
    Bucket: str
    ChecksumMode: Optional[S3ObjectChecksumMode]
    ExpectedBucketOwner: Optional[str]
    IfMatch: Optional[str]
    IfModifiedSince: Optional[datetime]
    IfNoneMatch: Optional[str]
    IfUnmodifiedSince: Optional[datetime]
    Key: str
    PartNumber: Optional[int]
    Range: Optional[str]
    RequestPayer: Optional[str]
    SSECustomerAlgorithm: Optional[str]
    SSECustomerKey: Optional[str]
    VersionId: Optional[str]


class S3HeadObjectOutput(TypedDict):
    AcceptRanges: str
    ArchiveStatus: S3ObjectArchieveStatus
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
    ReplicationStatus: S3ObjectReplicationStatus
    RequestCharged: str
    Restore: str
    SSECustomerAlgorithm: str
    SSECustomerKeyMD5: str
    SSEKMSKeyId: str
    ServerSideEncryption: S3ObjectServerSideEncryption
    StorageClass: S3ObjectStorageClass
    VersionId: str
    WebsiteRedirectLocation: str


class S3PutObjectInput(TypedDict):
    ACL: Optional[S3ObjectACL]
    Body: ByteString
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


class S3PutObjectOutput(TypedDict):
    BucketKeyEnabled: bool
    ChecksumCRC32: Optional[str]
    ChecksumCRC32C: Optional[str]
    ChecksumSHA1: Optional[str]
    ChecksumSHA256: Optional[str]
    ETag: str
    Expiration: Optional[str]
    RequestCharged: Optional[str]
    SSECustomerAlgorithm: Optional[str]
    SSECustomerKeyMD5: Optional[str]
    SSEKMSEncryptionContext: Optional[str]
    SSEKMSKeyId: Optional[str]
    ServerSideEncryption: S3ObjectServerSideEncryption
    VersionId: Optional[str]


class S3Object(TypedDict):
    Bucket: str
    ContentDisposition: str
    ContentEncoding: str
    ContentLanguage: str
    ContentLength: int
    ContentType: str
    ETag: str
    Expiration: str
    Key: str
    PartsCount: int
    VersionId: str


class AbstractS3Client(ABC):
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
        RequestPayer: Optional[str],
        PartNumber: Optional[int],
        ExpectedBucketOwner: Optional[str],
        ChecksumMode: Optional[S3ObjectChecksumMode],
    ) -> S3HeadObjectOutput:
        raise NotImplementedError

    @abstractmethod
    def put_object(
        self,
        ACL: Optional[S3ObjectACL],
        Body: ByteString,
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
    ) -> S3PutObjectOutput:
        raise NotImplementedError


class S3Client:
    def head_object(
        self, s3_head_object_input: S3HeadObjectInput
    ) -> S3HeadObjectOutput:
        return self._client.head_object(**s3_head_object_input)

    def put_object(self, s3_put_object_input: S3PutObjectInput) -> S3PutObjectOutput:
        return self._client.put_object(**s3_put_object_input)

    def __init__(self, client: AbstractS3Client):
        self._client = client


class FunctionInput(TypedDict):
    body: TextImageInput


class FunctionOutputBody(TypedDict):
    objects: List[S3Object]


FunctionOutputContentType = Literal["application/json"]


class FunctionOutput(TypedDict):
    body: FunctionOutputBody
    headers: Optional[Dict[str, str]]
    statusCode: int


if not "S3_BUCKET_ACL" in environ:
    raise EnvironmentError("S3_BUCKET_ACL")
if not "S3_BUCKET_NAME" in environ:
    raise EnvironmentError("S3_BUCKET_NAME")
if not "S3_BUCKET_FOLDER" in environ:
    raise EnvironmentError("S3_BUCKET_FOLDER")

ENV_S3_BUCKET_ACL = environ["S3_BUCKET_ACL"]
ENV_S3_BUCKET_FOLDER = environ["S3_BUCKET_FOLDER"]
ENV_S3_BUCKET_NAME = environ["S3_BUCKET_NAME"]

bedrock_runtime = BedrockRuntime(client=client(service_name="bedrock-runtime"))
s3_client = S3Client(client=client(service_name="s3"))


def main(function_input: FunctionInput, _=None) -> FunctionOutput:

    text_image_input_image_generation_config = TextImageInputImageGenerationConfig(
        **function_input["body"]["imageGenerationConfig"]
    )
    text_image_input_text_to_image_params = TextImageInputTextToImageParams(
        **function_input["body"]["textToImageParams"]
    )

    if "negativeText" in text_image_input_text_to_image_params:
        if text_image_input_text_to_image_params["negativeText"] is None:
            del text_image_input_text_to_image_params["negativeText"]

    text_image_input = TextImageInput(
        imageGenerationConfig=text_image_input_image_generation_config,
        taskType="TEXT_IMAGE",
        textToImageParams=text_image_input_text_to_image_params,
    )

    bedrock_invoke_model_input_body = dumps(text_image_input)
    bedrock_invoke_model_input = BedrockInvokeModelInput(
        accept="application/json",
        body=bedrock_invoke_model_input_body,
        contentType="application/json",
        modelId="amazon.titan-image-generator-v1",
    )

    invoke_model_output = bedrock_runtime.invoke_model(
        bedrock_invoke_model_input=bedrock_invoke_model_input
    )

    invoke_model_output_body = invoke_model_output["body"].read()

    text_image_output = TextImageOutput(**loads(invoke_model_output_body))

    s3_objects: List[S3Object] = []

    for base64_encoded_image in text_image_output["images"]:

        base64_decoded_image = b64decode(base64_encoded_image)
        base64_decoded_image_md5 = md5(base64_decoded_image)
        base64_decoded_image_md5_hexdigest = base64_decoded_image_md5.hexdigest()
        base64_decoded_image_filename = base64_decoded_image_md5_hexdigest + ".png"

        s3_put_object_acl = ENV_S3_BUCKET_ACL
        s3_put_object_input_bucket = ENV_S3_BUCKET_NAME
        s3_put_object_input_key = path.join(
            ENV_S3_BUCKET_FOLDER, base64_decoded_image_filename
        )

        s3_put_object_input = S3PutObjectInput(
            ACL=s3_put_object_acl,
            Body=base64_decoded_image,
            Bucket=s3_put_object_input_bucket,
            ContentLanguage="en-US",
            ContentLength=len(base64_decoded_image),
            ContentType="image/png",
            Key=s3_put_object_input_key,
        )

        s3_put_object_output = s3_client.put_object(
            s3_put_object_input=s3_put_object_input
        )

        print(s3_put_object_output)

        s3_head_object_input = S3HeadObjectInput(
            Bucket=s3_put_object_input_bucket,
            Key=s3_put_object_input_key,
        )

        s3_head_object_output = s3_client.head_object(
            s3_head_object_input=s3_head_object_input
        )

        print(s3_head_object_output)

        s3_object = S3Object(
            Bucket=s3_put_object_input["Bucket"],
            ContentDisposition=s3_head_object_output.get("ContentDisposition"),
            ContentEncoding=s3_head_object_output.get("ContentEncoding"),
            ContentLanguage=s3_head_object_output.get("ContentLanguage"),
            ContentLength=s3_head_object_output.get("ContentLength"),
            ContentType=s3_head_object_output.get("ContentType"),
            ETag=s3_head_object_output.get("ETag"),
            Expiration=s3_head_object_output.get("Expiration"),
            Key=s3_put_object_input["Key"],
            PartsCount=s3_head_object_output.get("PartsCount"),
            VersionId=s3_head_object_output.get("VersionId"),
        )

        print(s3_object)

        s3_objects.append(s3_object)

    function_output_body = FunctionOutputBody(objects=s3_objects)
    function_output = FunctionOutput(
        body=function_output_body,
        headers={
            "content-type": "application/json",
        },
        statusCode=HTTPStatus.OK,
    )

    return function_output


if __name__ == "__main__":

    function_input = {
        "body": {
            "taskType": "TEXT_IMAGE",
            "textToImageParams": {
                "negativeText": None,
                "text": "A photograph of a cup of coffee from the side.",
            },
            "imageGenerationConfig": {
                "numberOfImages": 1,
                "height": 1024,
                "width": 1024,
                "cfgScale": 8.0,
                "seed": 0,
            },
        }
    }

    main(function_input, None)
