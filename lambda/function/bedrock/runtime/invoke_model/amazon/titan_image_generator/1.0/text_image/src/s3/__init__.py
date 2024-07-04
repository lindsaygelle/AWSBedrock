from abc import ABC, abstractmethod
from datetime import datetime
from typing import ByteString, Dict, Literal, Optional, TypedDict

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

S3GeneratePresignedURLClientMethod = Literal["get_object"]


class S3GeneratePresignedURLInput(TypedDict):
    Expires: int
    Params: Dict[str, str]


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
    def generate_presigned_url(
        self,
        client_method: S3GeneratePresignedURLClientMethod,
        Params: Dict[str, str],
        HttpMethod: str,
    ) -> str:
        raise NotImplementedError

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
    def generate_presigned_url(
        self,
        client_method: S3GeneratePresignedURLClientMethod,
        s3_generate_presigned_url_input: S3GeneratePresignedURLInput,
        http_method: Optional[str] = None,
    ) -> str:
        return self._client.generate_presigned_url(
            client_method=client_method,
            Params=s3_generate_presigned_url_input,
            HttpMethod=http_method,
        )

    def head_object(
        self, s3_head_object_input: S3HeadObjectInput
    ) -> S3HeadObjectOutput:
        return self._client.head_object(**s3_head_object_input)

    def put_object(self, s3_put_object_input: S3PutObjectInput) -> S3PutObjectOutput:
        return self._client.put_object(**s3_put_object_input)

    def __init__(self, client: AbstractS3Client):
        self._client = client
