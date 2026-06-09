"""
Upload an image to Buttondown and return the hosted URL.

Usage:
    python images.py <image_path>

    Prints the hosted image URL to stdout on success.
    Exits with code 1 on failure.
"""

import os
import requests
import sys


def upload_image(image_path: str, api_key: str) -> str:
    """
    Upload an image to Buttondown's API.

    :arg image_path: Path to the image file to upload
    :arg api_key: Buttondown API key

    :returns: The URL of the uploaded image
    """
    if not os.path.exists(image_path):
        raise FileNotFoundError(f"Image file not found: {image_path}")

    url = "https://api.buttondown.com/v1/images"
    headers = {"Authorization": f"Token {api_key}"}

    with open(image_path, "rb") as f:
        files = {"image": (os.path.basename(image_path), f)}
        response = requests.post(url, headers=headers, files=files)

    if response.status_code == 201:
        data = response.json()
        return data["image"]
    else:
        error_detail = response.json().get("detail", "Unknown error")
        raise ValueError(f"Bad request: {response.status_code}, {error_detail}")


def main():
    if len(sys.argv) != 2:
        print("Usage: python images.py <image_path>", file=sys.stderr)
        sys.exit(1)

    image_path = sys.argv[1]

    api_key = os.environ.get("BUTTONDOWN_API_KEY")
    if not api_key:
        print(
            "Error: BUTTONDOWN_API_KEY environment variable is not set", file=sys.stderr
        )
        sys.exit(1)

    try:
        image_url = upload_image(image_path, api_key)
        print(image_url)
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
