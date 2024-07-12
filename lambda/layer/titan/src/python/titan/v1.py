from typing import ByteString, List, Literal, Optional, TypedDict

TaskTypeImageVariation = Literal["IMAGE_VARIATION"]
TaskTypeInPainting = Literal["INPAINTING"]
TaskTypeOutPainting = Literal["OUTPAINTING"]
TaskTypeTextImage = Literal["TEXT_IMAGE"]
TaskType = (
    TaskTypeImageVariation
    | TaskTypeInPainting
    | TaskTypeTextImage
    | TaskTypeOutPainting
)


class ImageGenerationConfig(TypedDict):
    cfgScale: Optional[float]
    height: Optional[int]
    numberOfImages: Optional[int]
    seed: Optional[int]
    width: Optional[int]


class ImageVariationParams(TypedDict):
    images: List[ByteString]
    negativeText: Optional[str]
    similarityStrength: Optional[float]
    text: str


class InPaintingParams(TypedDict):
    image: ByteString
    maskImage: Optional[ByteString]
    maskPrompt: Optional[str]
    negativeText: Optional[str]
    text: str


class OutPaintingParams(TypedDict):
    image: ByteString
    maskImage: Optional[ByteString]
    maskPrompt: Optional[str]
    negativeText: Optional[str]
    outPaintingMode: Literal["DEFAULT", "PRECISE"]
    text: str


class TextToImageParams(TypedDict):
    negativeText: Optional[str]
    text: str


class ImageVariation(TypedDict):
    imageGenerationConfig: Optional[ImageGenerationConfig]
    imageVariationParams: ImageVariationParams
    taskType: TaskTypeImageVariation


class InPainting(TypedDict):
    imageGenerationConfig: Optional[ImageGenerationConfig]
    inPaintingParams: InPaintingParams
    taskType: TaskTypeInPainting


class OutPainting(TypedDict):
    imageGenerationConfig: Optional[ImageGenerationConfig]
    outPaintingParams: OutPaintingParams
    taskType: TaskTypeOutPainting


class TextImage(TypedDict):
    imageGenerationConfig: ImageGenerationConfig
    taskType: TaskTypeTextImage
    textToImageParams: TextToImageParams


class ImageGenerator(ImageVariation, InPainting, OutPainting, TextImage):
    taskType: TaskType
