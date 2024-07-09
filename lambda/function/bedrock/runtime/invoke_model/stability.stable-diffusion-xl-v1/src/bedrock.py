from abc import ABC, abstractmethod
from botocore.response import StreamingBody
from typing import ByteString, Literal, Optional, TypedDict
import boto3


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
