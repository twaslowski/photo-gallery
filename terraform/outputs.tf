output "b2_bucket_name" {
  description = "Name of the B2 photos bucket"
  value       = b2_bucket.photos.bucket_name
}

output "b2_bucket_id" {
  description = "ID of the B2 photos bucket"
  value       = b2_bucket.photos.bucket_id
}

output "b2_application_key_id" {
  description = "Application key ID for read-only access"
  value       = b2_application_key.photos_readonly.application_key_id
}

output "b2_application_key" {
  description = "Application key for read-only access"
  value       = b2_application_key.photos_readonly.application_key
  sensitive   = true
}

output "site_url" {
  description = "URL of the gallery site"
  value       = "https://${var.site_subdomain}.${var.domain}"
}

output "images_url" {
  description = "URL for serving images"
  value       = "https://${var.images_subdomain}.${var.domain}"
}

