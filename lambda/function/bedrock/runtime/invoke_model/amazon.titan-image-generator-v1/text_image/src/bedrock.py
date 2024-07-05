from abc import ABC, abstractmethod
from base64 import b64decode
from hashlib import md5
from botocore.response import StreamingBody
from typing import ByteString, List, Literal, Optional, TypedDict
import boto3


class Base64Image:
    def __init__(self, s: str):
        self.bytes = b64decode(s.encode("ascii"))
        self.md5_hexdigest = md5(self.bytes).hexdigest()
        self.size = len(self.bytes)


class OutputInvokeModelBody(TypedDict):
    error: Optional[str]
    images: List[str]


class OutputInvokeModel(TypedDict):
    body: StreamingBody
    contentType: Literal["application/json"]


class AbstractRuntime(ABC):
    @abstractmethod
    def invoke_model(
        self,
        body: ByteString,
        contentType: Literal["application/json"],
        accept: Literal["application/json"],
        modelId: Literal["amazon.titan-image-generator-v1"],
        trace: Optional[Literal["DISABLED", "ENABLED"]],
        guardrailIdentifier: Optional[str],
        guardrailVersion: Optional[str],
    ) -> OutputInvokeModel:
        raise NotImplementedError


def runtime() -> AbstractRuntime:
    return boto3.client("bedrock-runtime")
