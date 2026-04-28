variable "domain" {
  description = "The base domain (e.g. yourdomain.com)"
  type        = string
}

variable "images_subdomain" {
  description = "Subdomain for serving images from B2 (e.g. img)"
  type        = string
  default     = "img"
}

variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID for your domain"
  type        = string
}

variable "cloudflare_api_token" {
  description = "Cloudflare API token"
  type        = string
  sensitive   = true
}

variable "b2_bucket_name" {
  description = "Name of the B2 bucket for web photos"
  type        = string
  default     = "photos-web"
}

variable "site_subdomain" {
  description = "Subdomain for the gallery site (e.g. photography)"
  type        = string
  default     = "photography"
}

variable "github_username" {
  description = "Your GitHub username (for Pages CNAME)"
  type        = string
}
