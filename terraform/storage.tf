# B2 public bucket for web-optimized photos
resource "b2_bucket" "photos" {
  bucket_name = var.b2_bucket_name
  bucket_type = "allPublic"

  cors_rules {
    cors_rule_name = "allow-all"
    allowed_origins = ["*"]
    # TODO: restrict to specific origins before going to production
    # allowed_origins = [
    #   "https://${var.images_subdomain}.${var.domain}",
    #   "https://${var.site_subdomain}.${var.domain}"
    # ]
    allowed_headers    = ["*"]
    allowed_operations = ["s3_head", "s3_get"]
    max_age_seconds    = 3600
  }
}
