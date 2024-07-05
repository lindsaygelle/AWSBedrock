from abc import ABC, abstractmethod
from datetime import datetime
from typing import ByteString, Dict, Literal, Optional, TypedDict
import boto3

ObjectACL = Literal[
    "authenticated-read",
    "aws-exec-read",
    "bucket-owner-full-control",
    "bucket-owner-read",
    "private",
    "public-read",
    "public-read-write",
]
ObjectArchieveStatus = Literal["ARCHIVE_ACCESS", "DEEP_ARCHIVE_ACCESS"]
ObjectChecksumAlgorithm = Literal["CRC32", "CRC32C", "SHA1", "SHA256"]
ObjectChecksumMode = Literal["ENABLED"]
ObjectLockLegalHoldStatus = Literal["OFF", "ON"]
ObjectLockMode = Literal["COMPLIANCE", "GOVERNANCE"]
ObjectReplicationStatus = Literal[
    "COMPLETE", "COMPLETED", "FAILED", "PENDING", "REPLICA"
]
ObjectStorageClass = Literal[
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
ObjectServerSideEncryption = Literal["AES256", "aws:kms", "aws:kms:dsse"]


class OutputHeadObject(TypedDict):
    AcceptRanges: Optional[str]
    ArchiveStatus: Optional[ObjectArchieveStatus]
    BucketKeyEnabled: Optional[bool]
    CacheControl: Optional[str]
    ChecksumCRC32: Optional[str]
    ChecksumCRC32C: Optional[str]
    ChecksumSHA1: Optional[str]
    ChecksumSHA256: Optional[str]
    ContentDisposition: Optional[str]
    ContentEncoding: Optional[str]
    ContentLanguage: Optional[str]
    ContentLength: int
    ContentType: Optional[str]
    DeleteMarker: Optional[bool]
    ETag: str
    Expiration: Optional[str]
    Expires: Optional[datetime]
    LastModified: Optional[datetime]
    Metadata: Optional[Dict[str, str]]
    MissingMeta: Optional[int]
    ObjectLockLegalHoldStatus: Optional[ObjectLockLegalHoldStatus]
    ObjectLockMode: Optional[ObjectLockMode]
    ObjectLockRetainUntilDate: Optional[datetime]
    PartsCount: Optional[int]
    ReplicationStatus: Optional[ObjectReplicationStatus]
    RequestCharged: Optional[str]
    Restore: Optional[str]
    SSECustomerAlgorithm: Optional[str]
    SSECustomerKeyMD5: Optional[str]
    SSEKMSKeyId: Optional[str]
    ServerSideEncryption: ObjectServerSideEncryption
    StorageClass: Optional[ObjectStorageClass]
    VersionId: Optional[str]
    WebsiteRedirectLocation: Optional[str]


class OutputPutObject(TypedDict):
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
    ServerSideEncryption: ObjectServerSideEncryption
    VersionId: Optional[str]


class AbstractClient(ABC):
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
        ChecksumMode: Optional[ObjectChecksumMode],
    ) -> OutputHeadObject:
        raise NotImplementedError

    @abstractmethod
    def put_object(
        self,
        ACL: Optional[ObjectACL],
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
        ServerSideEncryption: Optional[ObjectServerSideEncryption],
        StorageClass: Optional[ObjectStorageClass],
        WebsiteRedirectLocation: Optional[str],
        SSECustomerAlgorithm: Optional[str],
        SSECustomerKey: Optional[str],
        SSEKMSKeyId: Optional[str],
        SSEKMSEncryptionContext: Optional[str],
        BucketKeyEnabled: Optional[bool],
        RequestPayer: Optional[str],
        Tagging: Optional[str],
        ObjectLockMode: Optional[ObjectLockMode],
        ObjectLockRetainUntilDate: Optional[datetime],
        ObjectLockLegalHoldStatus: Optional[ObjectLockLegalHoldStatus],
        ExpectedBucketOwner: Optional[str],
    ) -> OutputPutObject:
        raise NotImplementedError


def client() -> AbstractClient:
    return boto3.client("s3")
