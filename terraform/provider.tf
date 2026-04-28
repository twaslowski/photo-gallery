terraform {
  required_version = ">= 1.14.0"

  required_providers {
    b2 = {
      source  = "Backblaze/b2"
      version = "~> 0.10"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.0"
    }
  }
}

provider "b2" {
  application_key    = var.b2_application_key
  application_key_id = var.b2_application_key_id
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
