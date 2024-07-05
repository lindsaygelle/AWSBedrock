from base64 import b64decode
from hashlib import md5
from os import environ
from typing import List, Literal, Optional, TypedDict
import json
import s3
import bedrock


bedrock_runtime = bedrock.runtime()
s3_client = s3.client()


class InputTextImage(TypedDict):
    imageGenerationConfig: dict
    taskType: Literal["TEXT_IMAGE"]
    textToImageParams: dict


class OutputTextImageImage(TypedDict):
    imageGenerationConfig: dict


class OutputTextImage(TypedDict):
    images: List[OutputTextImageImage]


def main(input_event: InputTextImage) -> OutputTextImage:

    invoke_model_output = bedrock_runtime.invoke_model(
        accept="application/json",
        body=json.dumps(input_event),
        contentType="application/json",
        modelId="amazon.titan-image-generator-v1",
    )

    body: bedrock.OutputInvokeModelBody = json.loads(invoke_model_output["body"])

    if ("error" in body) and (body["error"] is not None):
        raise Exception(body["error"])

    for encoded_base64_str in body["images"]:
        
        base64_image = bedrock.Base64Image(encoded_base64_str)

        s3_client.put_object(
            Bucket=""
        )

    return
