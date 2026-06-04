terraform {
  backend "s3" {}
  required_providers {
    vercel = {
      source  = "vercel/vercel"
      version = "3.5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.0"
    }
  }
}

provider "vercel" {
  api_token = var.vercel_api_key
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
