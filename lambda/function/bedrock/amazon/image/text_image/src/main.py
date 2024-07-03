from abc import ABC, abstractmethod
from base64 import b64decode
from binascii import Error as BinAsciiError
from boto3 import client
from botocore.exceptions import BotoCoreError, ClientError
from botocore.response import StreamingBody
from datetime import datetime
from hashlib import md5
from http import HTTPStatus
from json import JSONDecodeError, dumps, loads
from os import environ, path
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


class AmazonTitanImageGeneratorV1Response(TypedDict):
    images: List[AnyStr]


class AmazonTitanImageGeneratorV1RequestImageGenerationConfig(TypedDict):
    cfgScale: float
    height: int
    numberOfImages: int
    seed: int
    width: int


class AmazonTitanImageGeneratorV1RequestTextToImageParams(TypedDict):
    negativeText: Optional[str]
    text: str


class AmazonTitanImageGeneratorV1Request(TypedDict):
    imageGenerationConfig: AmazonTitanImageGeneratorV1RequestImageGenerationConfig
    taskType: Literal["TEXT_IMAGE"]
    textToImageParams: AmazonTitanImageGeneratorV1RequestTextToImageParams


class BedrockRuntimeInvokeModelResponseMetadata(TypedDict):
    HTTPHeaders: Dict[str, str]
    HTTPStatusCode: int
    RequestId: str
    RetryAttempts: int


class BedrockRuntimeInvokeModelResponse(TypedDict):
    ResponseMetadata: BedrockRuntimeInvokeModelResponseMetadata
    body: StreamingBody
    contentType: str


BedrockModelId = Literal["amazon.titan-image-generator-v1"]
BedrockRuntimeTrace = Literal[
    "DISABLED",
    "ENABLED",
]


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


class APIGatewayRequestAuthorizer(TypedDict):
    claims: Dict[str, str]
    principalId: str
    property: str


class APIGatewayRequestIdentity(TypedDict):
    accountId: str
    apiKey: str
    apiKeyId: str
    caller: str
    cognitoAuthenticationProvider: str
    cognitoAuthenticationType: str
    cognitoIdentityId: str
    cognitoIdentityPoolId: str
    principalOrgId: str
    sourceIp: str
    user: str
    userAgent: str
    userArn: str
    vpcId: str
    vpceId: str


class APIGatewayRequestRequestOverride(TypedDict):
    header: Dict[str, str]
    path: Dict[str, str]
    querystring: Dict[str, str]


class APIGatewayRequest(TypedDict):
    accountId: str
    apiId: str
    authorizer: APIGatewayRequestAuthorizer
    awsEndpointRequestId: str
    body: any
    deploymentId: str
    domainName: str
    domainPrefix: str
    extendedRequestId: str
    httpMethod: str
    identity: APIGatewayRequestIdentity
    isCanaryRequest: str
    path: str
    protocol: str
    requestId: str
    requestOverride: APIGatewayRequestRequestOverride
    requestHeaders: Dict[str, str]
    requestTime: str
    requestTimeEpoch: str
    resourceId: str
    resourcePath: str
    stage: str
    wafResponseCode: str
    webaclArn: str


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
S3ObjectMetadata = Dict[str, str]
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


class S3HeadObjectRequest(TypedDict):
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


class S3HeadObjectResponseMetadata(TypedDict):
    HTTPHeaders: Dict[str, str]
    HTTPStatusCode: int
    RequestId: str
    RetryAttempts: int


class S3HeadObjectResponse(TypedDict):
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


class S3PutObjectResponseMetadata(TypedDict):
    HTTPHeaders: Dict[str, str]
    HTTPStatusCode: int
    RequestId: str
    RetryAttempts: int


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


class S3Object(S3HeadObjectResponse):
    Bucket: str
    Key: str


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
        RequestPayer: Optional[str],
        PartNumber: Optional[int],
        ExpectedBucketOwner: Optional[str],
        ChecksumMode: Optional[S3ObjectChecksumMode],
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


class LambdaResponseBodyObject(TypedDict):
    Bucket: str
    Key: str


class LambdaResponseBody(TypedDict):
    Error: Optional[
        Literal[
            "INVALID_BEDROCK_REQUEST",
            "INVALID_BEDROCK_RESPONSE",
            "INVALID_LAMBDA_REQUEST",
            "RUNTIME_EXCEPTION",
        ]
    ]
    Objects: Optional[List[LambdaResponseBodyObject]]


class LambdaResponse(TypedDict):
    Body: Optional[Union[LambdaResponseBody, None]]
    ContentType: Optional[Union[Literal["application/json"], None]]
    StatusCode: int


bedrock_runtime: BedrockRuntime = client("bedrock-runtime")
s3_client: S3Client = client("s3")


def main(api_gateway_request: APIGatewayRequest, _=None) -> LambdaResponse:

    if not isinstance(api_gateway_request, dict):
        return LambdaResponse(
            Body=LambdaResponseBody(
                Error="INVALID_LAMBDA_REQUEST",
            ),
            StatusCode=HTTPStatus.BAD_REQUEST,
        )

    if not ("body" in api_gateway_request):
        return LambdaResponse(
            Body=LambdaResponseBody(
                Error="INVALID_LAMBDA_REQUEST",
            ),
            StatusCode=HTTPStatus.BAD_REQUEST,
        )

    api_gateway_request_body = api_gateway_request["body"]

    print(api_gateway_request_body)

    if not (isinstance(api_gateway_request_body, dict)):
        return LambdaResponse(
            Body=LambdaResponseBody(
                Error="INVALID_LAMBDA_REQUEST",
            ),
            StatusCode=HTTPStatus.BAD_REQUEST,
        )

    if not ("imageGenerationConfig" in api_gateway_request_body):
        raise KeyError("imageGenerationConfig")

    amazon_titan_image_generator_v1_request_image_generation_config: (
        AmazonTitanImageGeneratorV1RequestImageGenerationConfig
    ) = api_gateway_request_body["imageGenerationConfig"]

    print(amazon_titan_image_generator_v1_request_image_generation_config)

    if not (
        isinstance(
            amazon_titan_image_generator_v1_request_image_generation_config, dict
        )
    ):
        return LambdaResponse(
            Body=LambdaResponseBody(
                Error="INVALID_LAMBDA_REQUEST",
            ),
            StatusCode=HTTPStatus.BAD_REQUEST,
        )

    if not ("textToImageParams" in api_gateway_request_body):
        raise KeyError("textToImageParams")

    amazon_titan_image_generator_v1_request_text_to_image_params: (
        AmazonTitanImageGeneratorV1RequestTextToImageParams
    ) = api_gateway_request_body["textToImageParams"]

    print(amazon_titan_image_generator_v1_request_text_to_image_params)

    if not (
        isinstance(amazon_titan_image_generator_v1_request_text_to_image_params, dict)
    ):
        return LambdaResponse(
            Body=LambdaResponseBody(
                Error="INVALID_LAMBDA_REQUEST",
            ),
            StatusCode=HTTPStatus.BAD_REQUEST,
        )

    if "negativeText" in amazon_titan_image_generator_v1_request_text_to_image_params:
        if (
            amazon_titan_image_generator_v1_request_text_to_image_params["negativeText"]
            is None
        ):
            del amazon_titan_image_generator_v1_request_text_to_image_params[
                "negativeText"
            ]

    amazon_titan_image_generator_v1_request = AmazonTitanImageGeneratorV1Request(
        imageGenerationConfig=amazon_titan_image_generator_v1_request_image_generation_config,
        taskType="TEXT_IMAGE",
        textToImageParams=amazon_titan_image_generator_v1_request_text_to_image_params,
    )

    print(amazon_titan_image_generator_v1_request)

    bedrock_runtime_invoke_model_request_model_id = api_gateway_request_body.get(
        "modelId", "amazon.titan-image-generator-v1"
    )

    try:
        bedrock_runtime_invoke_model_request_body = dumps(
            amazon_titan_image_generator_v1_request
        )
    except JSONDecodeError as e:

        print(e)

        return LambdaResponse(
            Body=LambdaResponseBody(
                Error="RUNTIME_EXCEPTION",
            ),
            StatusCode=HTTPStatus.INTERNAL_SERVER_ERROR,
        )

    bedrock_runtime_invoke_model_request = BedrockRuntimeInvokeModelRequest(
        accept="application/json",
        body=bedrock_runtime_invoke_model_request_body,
        contentType="application/json",
        modelId=bedrock_runtime_invoke_model_request_model_id,
    )

    try:
        bedrock_runtime_invoke_model_response = bedrock_runtime.invoke_model(
            **bedrock_runtime_invoke_model_request
        )
    except ClientError as e:

        print(e)

        return LambdaResponse(
            Body=LambdaResponseBody(
                Error="INVALID_BEDROCK_REQUEST",
            ),
            StatusCode=HTTPStatus.BAD_REQUEST,
        )

    bedrock_runtime_invoke_model_response_metadata = (
        bedrock_runtime_invoke_model_response["ResponseMetadata"]
    )

    if (
        bedrock_runtime_invoke_model_response_metadata["HTTPStatusCode"]
        != HTTPStatus.OK
    ):
        return LambdaResponse(
            Body=LambdaResponseBody(
                Error="INVALID_BEDROCK_RESPONSE",
            ),
            StatusCode=HTTPStatus.BAD_REQUEST,
        )

    try:
        amazon_titan_image_generator_v1_response: (
            AmazonTitanImageGeneratorV1Response
        ) = loads(bedrock_runtime_invoke_model_response["body"].read())
    except JSONDecodeError as e:

        print(e)

        return LambdaResponse(
            Body=LambdaResponseBody(
                Error="RUNTIME_EXCEPTION",
            ),
            StatusCode=HTTPStatus.INTERNAL_SERVER_ERROR,
        )

    s3_objects: List[S3Object] = []

    for base64_image in amazon_titan_image_generator_v1_response["images"]:

        try:
            decoded_image = b64decode(base64_image)

            try:
                decoded_image_md5 = md5(decoded_image)
                decoded_image_md5_hexdigest = decoded_image_md5.hexdigest()

            except TypeError as e:
                # TODO: Add an error
                print(e)
                continue

            s3_bucket_acl: Optional[str] = environ["S3_BUCKET_ACL"]
            s3_bucket_folder: Optional[str] = environ["S3_BUCKET_FOLDER"]
            s3_bucket_name: Optional[str] = environ["S3_BUCKET_NAME"]
            s3_object_key = path.join(s3_bucket_folder, decoded_image_md5_hexdigest) + ".png"

            s3_put_object_request = S3PutObjectRequest(
                ACL=s3_bucket_acl,
                Body=decoded_image,
                Bucket=s3_bucket_name,
                ContentLanguage="en-US",
                ContentLength=len(decoded_image),
                ContentType="image/png",
                Key=s3_object_key,
            )

            try:
                s3_put_object_response = s3_client.put_object(**s3_put_object_request)

                print(s3_put_object_response)

            except ClientError as e:
                # TODO: Add an error
                print(e)
                continue

            s3_head_object_request = S3HeadObjectRequest(
                Bucket=s3_bucket_name, Key=s3_object_key
            )
            try:
                s3_head_object_response = s3_client.head_object(
                    **s3_head_object_request
                )
            except ClientError as e:
                # TODO: Add an error
                print(e)
                continue

            print(s3_head_object_response)

            for key in (
                "Expires",
                "LastModified",
                "ObjectLockRetainUntilDate",
            ):
                if key in s3_head_object_response:
                    s3_head_object_response[key] = str(s3_head_object_response[key])

            s3_object = S3Object(
                Bucket=s3_head_object_request["Bucket"],
                Key=s3_head_object_request["Key"],
                **s3_head_object_response
            )

            s3_objects.append(s3_object)

        except BinAsciiError as e:
            # TODO: Add an error
            print(e)
            continue

    lambda_response_body = LambdaResponseBody(Objects=s3_objects)

    lambda_response = LambdaResponse(
        Body=lambda_response_body,
        ContentType="application/json",
        StatusCode=HTTPStatus.OK,
    )

    return lambda_response
