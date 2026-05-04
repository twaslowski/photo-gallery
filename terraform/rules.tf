resource "cloudflare_ruleset" "bucket_rewrite" {
  name        = "b2-bucket-object-rewrite"
  description = "Rewrite bucket name in request URL for Backblaze B2 bucket access"

  zone_id = var.cloudflare_zone_id
  phase   = "http_request_transform"
  kind    = "zone"

  rules = [
    {
      description = "Rewrite bucket name in request URL for Backblaze B2 bucket access"
      enabled     = true
      expression  = "(http.request.full_uri wildcard r\"https://${var.images_subdomain}.${var.domain}/file/*\")"

      action = "rewrite"
      action_parameters = {
        uri = {
          path = {
            expression = "wildcard_replace(http.request.uri.path, r\"/file/*\", r\"/file/${var.b2_bucket_name}/$${1}\")"
          }
        }
      }
    }
  ]
}
