# CNAME for images subdomain -> B2 bucket (Bandwidth Alliance = free egress)
resource "cloudflare_dns_record" "images" {
  zone_id = var.cloudflare_zone_id
  name    = var.images_subdomain
  type    = "CNAME"
  content = "f003.backblazeb2.com"
  proxied = true
  ttl     = 1 # auto when proxied

  comment = "managed-by:terraform;application:photo-gallery"
}

# CNAME for site domain -> GitHub Pages
resource "cloudflare_dns_record" "pages" {
  zone_id = var.cloudflare_zone_id
  name    = var.site_subdomain
  type    = "CNAME"
  content = "${var.github_username}.github.io"
  proxied = false
  ttl     = 3600

  comment = "managed-by:terraform;application:photo-gallery"
}
