from typing import Literal, Optional, TypedDict

TaskType = Literal["TEXT_IMAGE"]


class ImageGenerationConfig(TypedDict):
    cfgScale: Optional[float]
    height: Optional[int]
    numberOfImages: Optional[int]
    seed: Optional[int]
    width: Optional[int]


class TextToImageParams(TypedDict):
    negativeText: Optional[str]
    text: str
