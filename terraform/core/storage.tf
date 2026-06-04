# B2 public bucket for web-optimized photos
resource "b2_bucket" "photos" {
  bucket_name = var.b2_bucket_name
  bucket_type = "allPublic"

  cors_rules {
    cors_rule_name  = "allow-all"
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

  lifecycle_rules {
    days_from_hiding_to_deleting                           = 1
    days_from_starting_to_canceling_unfinished_large_files = 0
    days_from_uploading_to_hiding                          = 0
    file_name_prefix                                       = ""
  }
}

# Read-only application key scoped to the photos bucket
resource "b2_application_key" "photos_readonly" {
  key_name     = "${var.b2_bucket_name}-readonly"
  capabilities = ["listBuckets", "readFiles", "listFiles"]
  bucket_ids   = [b2_bucket.photos.bucket_id]
}
