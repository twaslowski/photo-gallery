#!/usr/bin/env python3
"""
Create an email draft in Buttondown from a TOML newsletter file.

Usage:
    python draft.py <newsletter.toml>

Environment:
    BUTTONDOWN_API_KEY: Your Buttondown API key

The TOML file should have the following structure:
    subject = "Email Subject"
    text = "Email body content (Markdown supported)"
    image = "path/to/image.jpg"  # Optional
    image_alt = "Alt text"       # Optional
"""

import os
import sys
import tomllib
import requests

from images import upload_image


def create_draft(subject: str, body: str, api_key: str) -> dict:
    """Create a draft email in Buttondown."""
    url = "https://api.buttondown.com/v1/emails"
    headers = {"Authorization": f"Token {api_key}", "Content-Type": "application/json"}
    data = {"subject": subject, "body": body, "status": "draft"}

    response = requests.post(url, headers=headers, json=data)
    response.raise_for_status()
    return response.json()


def load_newsletter(toml_path: str) -> dict:
    """Load a newsletter from a TOML file."""
    with open(toml_path, "rb") as f:
        data = tomllib.load(f)

    if "subject" not in data or "text" not in data:
        raise ValueError("Missing required field: subject or text")

    return data


def build_email_body(newsletter: dict, image_url: str | None = None) -> str:
    """Build the email body from newsletter data."""
    body = newsletter["text"]
    if image_url:
        alt_text = newsletter.get("image_alt", "Newsletter image")
        body = f"![{alt_text}]({image_url})\n\n" + body
    return body


def main():
    if len(sys.argv) != 2:
        sys.exit("Usage: python draft.py <newsletter.toml>")

    toml_path = sys.argv[1]
    api_key = os.environ.get("BUTTONDOWN_API_KEY")
    if not api_key:
        sys.exit("Error: BUTTONDOWN_API_KEY environment variable is not set")

    try:
        newsletter = load_newsletter(toml_path)
        print(f"Loaded newsletter: {newsletter['subject']}")

        image_url = None
        if "image" in newsletter:
            image_path = newsletter["image"]
            toml_dir = os.path.dirname(os.path.abspath(toml_path))
            if not os.path.isabs(image_path):
                image_path = os.path.join(toml_dir, image_path)

            print(f"Uploading image: {image_path}")
            image_url = upload_image(image_path, api_key)
            print(f"Image uploaded: {image_url}")

        body = build_email_body(newsletter, image_url)

        print("Creating draft...")
        result = create_draft(newsletter["subject"], body, api_key)
        print(f"Draft created! ID: {result.get('id', 'N/A')}")

    except (FileNotFoundError, ValueError, requests.RequestException) as e:
        sys.exit(f"Error: {e}")


if __name__ == "__main__":
    main()
