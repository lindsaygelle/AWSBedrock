from base64 import b64decode
from bedrock import *
from boto3 import client
from hashlib import md5
from json import dumps, loads
from os import environ, path
from s3 import *
from typing import ByteString, List, Literal, Optional, TypedDict


class TextImageInputImageGenerationConfig(TypedDict):
    cfgScale: float
    height: int
    numberOfImages: int
    seed: int
    width: int


class TextImageInputTextToImageParams(TypedDict):
    negativeText: str
    text: str


class TextImageInput(TypedDict):
    imageGenerationConfig: TextImageInputImageGenerationConfig
    taskType: Literal["TEXT_IMAGE"]
    textToImageParams: TextImageInputTextToImageParams


class TextImageOutput(TypedDict):
    error: Optional[str]
    images: List[ByteString]


class FunctionInput(TypedDict):
    body: TextImageInput


class FunctionOutput(TypedDict):
    Objects: List[S3Object]


if not "S3_BUCKET_ACL" in environ:
    raise EnvironmentError("S3_BUCKET_ACL")
if not "S3_BUCKET_NAME" in environ:
    raise EnvironmentError("S3_BUCKET_NAME")
if not "S3_BUCKET_FOLDER" in environ:
    raise EnvironmentError("S3_BUCKET_FOLDER")

ENV_S3_BUCKET_ACL = environ["S3_BUCKET_ACL"]
ENV_S3_BUCKET_FOLDER = environ["S3_BUCKET_FOLDER"]
ENV_S3_BUCKET_NAME = environ["S3_BUCKET_NAME"]

bedrock_runtime = BedrockRuntime(client=client(service_name="bedrock-runtime"))
s3_client = S3Client(client=client(service_name="s3"))


def main(function_input: FunctionInput, _=None) -> FunctionOutput:

    text_image_input_image_generation_config = TextImageInputImageGenerationConfig(
        **function_input["body"]["imageGenerationConfig"]
    )
    text_image_input_text_to_image_params = TextImageInputTextToImageParams(
        **function_input["body"]["textToImageParams"]
    )

    if "negativeText" in text_image_input_text_to_image_params:
        if text_image_input_text_to_image_params["negativeText"] is None:
            del text_image_input_text_to_image_params["negativeText"]

    text_image_input = TextImageInput(
        imageGenerationConfig=text_image_input_image_generation_config,
        taskType="TEXT_IMAGE",
        textToImageParams=text_image_input_text_to_image_params,
    )

    bedrock_invoke_model_input_body = dumps(text_image_input)
    bedrock_invoke_model_input = BedrockInvokeModelInput(
        accept="application/json",
        body=bedrock_invoke_model_input_body,
        contentType="application/json",
        modelId="amazon.titan-image-generator-v1",
    )

    invoke_model_output = bedrock_runtime.invoke_model(
        bedrock_invoke_model_input=bedrock_invoke_model_input
    )

    invoke_model_output_body = invoke_model_output["body"].read()

    text_image_output = TextImageOutput(**loads(invoke_model_output_body))

    s3_objects: List[S3Object] = []

    for base64_encoded_image in text_image_output["images"]:

        base64_decoded_image = b64decode(base64_encoded_image)
        base64_decoded_image_md5 = md5(base64_decoded_image)
        base64_decoded_image_md5_hexdigest = base64_decoded_image_md5.hexdigest()
        base64_decoded_image_filename = base64_decoded_image_md5_hexdigest + ".png"

        s3_put_object_acl = ENV_S3_BUCKET_ACL
        s3_put_object_input_bucket = ENV_S3_BUCKET_NAME
        s3_put_object_input_key = path.join(
            ENV_S3_BUCKET_FOLDER, base64_decoded_image_filename
        )

        s3_put_object_input = S3PutObjectInput(
            ACL=s3_put_object_acl,
            Body=base64_decoded_image,
            Bucket=s3_put_object_input_bucket,
            ContentLanguage="en-US",
            ContentLength=len(base64_decoded_image),
            ContentType="image/png",
            Key=s3_put_object_input_key,
        )

        s3_put_object_output = s3_client.put_object(
            s3_put_object_input=s3_put_object_input
        )

        print(s3_put_object_output)

        s3_head_object_input = S3HeadObjectInput(
            Bucket=s3_put_object_input_bucket,
            Key=s3_put_object_input_key,
        )

        s3_head_object_output = s3_client.head_object(
            s3_head_object_input=s3_head_object_input
        )

        print(s3_head_object_output)

        s3_object = S3Object(
            Bucket=s3_put_object_input["Bucket"],
            ContentDisposition=s3_head_object_output.get("ContentDisposition"),
            ContentEncoding=s3_head_object_output.get("ContentEncoding"),
            ContentLanguage=s3_head_object_output.get("ContentLanguage"),
            ContentLength=s3_head_object_output.get("ContentLength"),
            ContentType=s3_head_object_output.get("ContentType"),
            ETag=s3_head_object_output.get("ETag"),
            Expiration=s3_head_object_output.get("Expiration"),
            Key=s3_put_object_input["Key"],
            PartsCount=s3_head_object_output.get("PartsCount"),
            VersionId=s3_head_object_output.get("VersionId"),
        )

        print(s3_object)

        s3_objects.append(s3_object)

    function_output = FunctionOutput(Objects=s3_objects)

    return function_output


if __name__ == "__main__":

    function_input = {
        "body": {
            "taskType": "TEXT_IMAGE",
            "textToImageParams": {
                "negativeText": None,
                "text": "A photograph of a cup of coffee from the side.",
            },
            "imageGenerationConfig": {
                "numberOfImages": 1,
                "height": 1024,
                "width": 1024,
                "cfgScale": 8.0,
                "seed": 0,
            },
        }
    }

    main(function_input, None)
