from abc import ABC, abstractmethod
from base64 import b64decode
from hashlib import md5
from botocore.response import StreamingBody
from typing import ByteString, List, Literal, Optional, TypedDict


class Base64Image:
    def __init__(self, s: str):
        s = s.encode("ascii")
        self.bytes = b64decode(s)
        self.md5 = md5(self.bytes)
        self.md5_hexdigest = self.md5.hexdigest()
        self.size = len(self.bytes)


class InputInvokeModel(TypedDict):
    body: ByteString


class OutputInvokeModelBody(TypedDict):
    error: Optional[str]
    images: List[str]


class OutputInvokeModel(TypedDict):
    body: StreamingBody
    contentType: Literal["application/json"]


class ExceptionInvokeModel(Exception):
    def __init__(self, body: OutputInvokeModelBody) -> None:
        super().__init__(body["error"])


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


class Runtime:
    __client: AbstractRuntime

    def invoke_model(
        self,
        input: InputInvokeModel,
    ) -> OutputInvokeModel:
        return self.__client.invoke_model(
            accept="application/json",
            body=input["body"],
            contentType="application/json",
            modelId="amazon.titan-image-generator-v1",
        )

    def __init__(self, client: AbstractRuntime):
        self.__client = client
