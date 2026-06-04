resource "cloudflare_dns_record" "app_domain" {
  name    = "tracking.twaslowski.com"
  ttl     = 36000
  type    = "CNAME"
  zone_id = var.cloudflare_zone_id
  content = "cname.vercel-dns.com"
  comment = "managed-by:terraform;application:photo-gallery"
}

resource "vercel_project_domain" "domain_prod" {
  project_id = vercel_project.project.id
  domain     = "tracking.twaslowski.com"
}