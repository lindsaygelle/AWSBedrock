from abc import ABC, abstractmethod
from botocore.response import StreamingBody
from typing import ByteString, Literal, Optional, TypedDict

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
