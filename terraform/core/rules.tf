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
      expression  = "(http.request.full_uri wildcard r\"https://${local.image_domain}/file/*\")"

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

resource "cloudflare_ruleset" "cache_rules_example" {
  zone_id     = var.cloudflare_zone_id
  name        = "Cache images"
  description = "Set cache settings for incoming requests"
  kind        = "zone"
  phase       = "http_request_cache_settings"

  rules = [{
    ref         = "cache_settings_custom_cache_key"
    description = "Set cache settings and custom cache key for example.net"
    expression  = "(http.host eq \"${local.image_domain}\")"
    action      = "set_cache_settings"

    action_parameters = {
      edge_ttl = {
        mode    = "override_origin"
        default = 7 * 24 * 3600

        status_code_ttl = [
          {
            status_code = 200
            value       = 7 * 24 * 3600
          },
          {
            status_code = 404
            value       = 0
          }
        ]
      }

      browser_ttl = {
        mode    = "override_origin"
        default = 30 * 24 * 3600 # 30 days
      }

      serve_stale = {
        disable_stale_while_updating = true
      }

      respect_strong_etags = true

      origin_error_page_passthru = false
    }
  }]
}