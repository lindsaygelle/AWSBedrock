from bedrock import (
    Base64Image,
    ExceptionInvokeModel,
    InputInvokeModel,
    OutputInvokeModelBody,
    Runtime as BedrockRuntime,
)
from boto3 import client
from os import environ
from s3 import (
    Client as S3Client,
    InputGetObjectInformation,
    InputPutObject,
    OutputObjectInformation,
)
from titan.v1 import ImageGenerationConfig, TextImage, TextToImageParams
from typing import List, TypedDict
import json


class InputEvent:
    imageGenerationConfig: ImageGenerationConfig
    textToImageParams: TextToImageParams


class OutputEvent(TypedDict):
    objects: List[OutputObjectInformation]


KEY_S3_BUCKET_ACL = "S3_BUCKET_ACL"
KEY_S3_BUCKET_NAME = "S3_BUCKET_NAME"
KEY_S3_BUCKET_OWNER = "S3_BUCKET_OWNER"

if KEY_S3_BUCKET_ACL not in environ:
    raise EnvironmentError(KEY_S3_BUCKET_ACL)
if KEY_S3_BUCKET_NAME not in environ:
    raise EnvironmentError(KEY_S3_BUCKET_NAME)
if KEY_S3_BUCKET_OWNER not in environ:
    raise EnvironmentError(KEY_S3_BUCKET_NAME)

ENV_S3_BUCKET_ACL = environ[KEY_S3_BUCKET_ACL]
ENV_S3_BUCKET_NAME = environ[KEY_S3_BUCKET_NAME]
ENV_S3_BUCKET_OWNER = environ[KEY_S3_BUCKET_OWNER]

bedrock_runtime = BedrockRuntime(client("bedrock-runtime"))
s3_client = S3Client(client("s3"))


def main(event: InputEvent, _=None) -> OutputEvent:

    if event["textToImageParams"]["negativeText"] is None:
        del event["textToImageParams"]["negativeText"]

    titan_text_image = TextImage(
        imageGenerationConfig=ImageGenerationConfig(**event["imageGenerationConfig"]),
        taskType="TEXT_IMAGE",
        textToImageParams=TextToImageParams(**event["textToImageParams"]),
    )

    print(titan_text_image)

    bedrock_input_invoke_model = InputInvokeModel(body=json.dumps(titan_text_image))

    print(bedrock_input_invoke_model)

    bedrock_output_invoke_model = bedrock_runtime.invoke_model(
        bedrock_input_invoke_model
    )

    bedrock_output_invoke_model_body = OutputInvokeModelBody(
        **json.loads(bedrock_output_invoke_model["body"].read())
    )

    if ("error" in bedrock_output_invoke_model_body) and (
        bedrock_output_invoke_model_body["error"] is not None
    ):
        raise ExceptionInvokeModel(bedrock_output_invoke_model_body)

    output_objects: List[OutputObjectInformation] = []

    for encoded_base64_str in bedrock_output_invoke_model_body["images"]:

        bedrock_base64_image = Base64Image(encoded_base64_str)

        bedrock_image_height = titan_text_image["imageGenerationConfig"]["height"]
        bedrock_image_width = titan_text_image["imageGenerationConfig"]["width"]

        s3_input_put_object = InputPutObject(
            ACL=ENV_S3_BUCKET_ACL,
            Body=bedrock_base64_image.bytes,
            Bucket=ENV_S3_BUCKET_NAME,
            ContentDisposition="inline",
            ContentLanguage="en-US",
            ContentLength=bedrock_base64_image.size,
            ContentType="image/png",
            ExpectedBucketOwner=ENV_S3_BUCKET_OWNER,
            Key=f"amazon.titan-image-generator-v1/text_image/{bedrock_image_height}x{bedrock_image_width}/{bedrock_base64_image.md5_hexdigest}.png",
            StorageClass="STANDARD",
        )

        s3_output_put_object = s3_client.put_object(s3_input_put_object)

        print(s3_output_put_object)

        s3_input_get_object_information = InputGetObjectInformation(
            Bucket=s3_input_put_object["Bucket"],
            Key=s3_input_put_object["Key"],
            ExpectedBucketOwner=s3_input_put_object["ExpectedBucketOwner"],
        )

        s3_get_object_information = s3_client.get_object_information(
            s3_input_get_object_information
        )

        print(s3_get_object_information)

        output_objects.append(s3_get_object_information)

    return OutputEvent(objects=output_objects)
