# Newsletter Publishing System

A standardized system for publishing newsletters via multiple channels, starting with Buttondown email.

## Newsletter Format (TOML)

Newsletters are defined using a TOML file with the following structure:

```toml
# Required fields
subject = "Newsletter Title"
text = """
Your newsletter content here.
Supports **Markdown** formatting.
"""

# Optional fields
image = "path/to/image.jpg"      # Local image path to upload and embed
image_alt = "Image description"   # Alt text for accessibility

[metadata]
author = "Your Name"
category = "photography"
```

See `newsletter.toml.example` for a complete example.

## Components

### images.py
Uploads an image to Buttondown's API and returns the hosted URL.

**Usage:**
```bash
export BUTTONDOWN_API_KEY="your-api-key"
python images.py path/to/image.jpg
```

**Output:**
Returns the URL of the uploaded image that can be embedded in emails.

### draft.py
Creates an email draft via the Buttondown API.

**Usage:**
```bash
export BUTTONDOWN_API_KEY="your-api-key"
python draft.py newsletter.toml
```

This will:
1. Parse the TOML file
2. Upload any specified image
3. Create a draft email with the content

## Environment Variables

- `BUTTONDOWN_API_KEY`: Your Buttondown API key (required)
  - Find it at: https://buttondown.com/requests

## Supported Image Formats

- PNG
- JPG/JPEG
- GIF

Note: SVG files are not recommended as most email clients don't render them reliably.

## Future Channels

The TOML format is designed to be extensible for other channels:
- Telegram
- Discord
- Social media posts

