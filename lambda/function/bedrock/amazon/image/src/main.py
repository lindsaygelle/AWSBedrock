from abc import ABC, abstractmethod
from http import HTTPStatus
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
    Body: ByteString | bytearray
    Bucket: str
    Key: str


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
        pass


bedrock_runtime_client: BedrockRuntime = boto3.client(service_name="bedrock-runtime")
s3_client = boto3.client("s3")


def main(event: Event, _):
    invoke_model_request_model_id = event["modelId"]
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

        put_object_request = PutObjectRequest(
            Body=base64.b64decode(base64_image),
            Bucket="",
            Key="{}/{}/{}.png".format(
                invoke_model_request_model_id,
                invoke_model_request_task_type,
                uuid.uuid4(),
            ),
        )
        put_object_response = s3_client.put_object(**put_object_request)
        print(put_object_response)


if __name__ == "__main__":
    main(
        {
            "body": {
                "taskType": "TEXT_IMAGE",
                "textToImageParams": {
                    "text": "A photograph of a cup of coffee from the side"
                },
                "imageGenerationConfig": {
                    "numberOfImages": 1,
                    "height": 512,
                    "width": 512,
                    "cfgScale": 8.0,
                    "seed": 20000,
                },
            },
            "modelId": "amazon.titan-image-generator-v1",
        },
        None,
    )
