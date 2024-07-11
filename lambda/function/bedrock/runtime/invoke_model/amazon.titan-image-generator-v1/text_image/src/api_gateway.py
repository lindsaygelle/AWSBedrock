from typing import Any, Optional, TypedDict


class HttpRequest(TypedDict):
    apiId: str
    body: Optional[Any]
    httpMethod: str
    path: str
    protocol: str
    requestId: str
    requestTime: str
    requestTimeEpoch: str
    resourceId: str
    resourcePath: str
    stage: str
