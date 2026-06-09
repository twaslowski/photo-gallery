from dataclasses import dataclass


@dataclass
class Newsletter:
    subject: str
    text: str
    image: str | None = None
    image_alt: str | None = None
