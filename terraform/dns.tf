# CNAME for images subdomain -> B2 bucket (Bandwidth Alliance = free egress)
resource "cloudflare_dns_record" "images" {
  zone_id = var.cloudflare_zone_id
  name    = var.images_subdomain
  type    = "CNAME"
  content = "f005.backblazeb2.com"
  proxied = true
  ttl     = 1 # auto when proxied
}

# CNAME for site domain -> GitHub Pages
resource "cloudflare_dns_record" "pages" {
  zone_id = var.cloudflare_zone_id
  name    = var.site_subdomain
  type    = "CNAME"
  content = "${var.github_username}.github.io"
  proxied = true
  ttl     = 1
}

# Cache rule for images — aggressive edge caching
resource "cloudflare_ruleset" "cache_images" {
  zone_id = var.cloudflare_zone_id
  name    = "Cache images from B2"
  kind    = "zone"
  phase   = "http_request_cache_settings"

  rules {
    expression  = "(http.host eq \"${var.images_subdomain}.${var.domain}\" and http.request.uri.path.extension in {\"jpg\" \"jpeg\" \"png\" \"webp\" \"avif\"})"
    action      = "set_cache_settings"
    description = "Aggressively cache image assets"

    action_parameters {
      cache = true

      edge_ttl {
        mode    = "override_origin"
        default = 2592000 # 30 days
      }

      browser_ttl {
        mode    = "override_origin"
        default = 604800 # 7 days
      }
    }
  }
}
