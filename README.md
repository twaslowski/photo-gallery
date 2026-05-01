# photography blog

This repository provides a really easy way to host your own image gallery.
It works with GitHub Pages, Backblaze B2 and Cloudflare.
The Hugo static site generator is used to create the gallery.

## Creating Posts

Posts are added at `content/posts`, as per Hugo convention.
Images can be referenced via the `img` macro, which resolves to the bucket base url defined in
`params.imageBaseURL`.

## Infrastructure

All infrastructure is managed via Terraform in the `terraform/` directory. It provisions:

- **Backblaze B2** — a public bucket for web-optimized photos with CORS rules and a read-only application key
- **Cloudflare DNS** — CNAME records pointing your domain to GitHub Pages and an images subdomain to B2
- **Cloudflare Cache** — aggressive edge/browser caching for image assets (leverages the Cloudflare ↔ B2 Bandwidth
  Alliance for free egress)

### Prerequisites

| Tool                                                                    | Version  |
|-------------------------------------------------------------------------|----------|
| [Terraform](https://developer.hashicorp.com/terraform/install)          | ≥ 1.14.0 |
| [Backblaze B2 account](https://www.backblaze.com/sign-up/cloud-storage) | —        |
| [Cloudflare account](https://dash.cloudflare.com/sign-up)               | —        |

### Required credentials

| Variable                | How to obtain                                                                              |
|-------------------------|--------------------------------------------------------------------------------------------|
| `B2_APPLICATION_KEY_ID` | Backblaze → App Keys → Master key or new key                                               |
| `B2_APPLICATION_KEY`    | Shown once when creating the key above                                                     |
| `cloudflare_api_token`  | Cloudflare → My Profile → API Tokens → Create Token (needs Zone:DNS:Edit, Zone:Cache:Edit) |
| `cloudflare_zone_id`    | Cloudflare dashboard → your domain → Overview sidebar                                      |

The B2 provider reads `B2_APPLICATION_KEY_ID` and `B2_APPLICATION_KEY` from environment variables.

### Applying

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your values

export B2_APPLICATION_KEY_ID="your-key-id"
export B2_APPLICATION_KEY="your-key"

terraform init
terraform plan
terraform apply
```

### Outputs

After applying, Terraform will output:

- `site_url` — the public URL of the gallery (e.g. `https://photography.mydomain.com`)
- `images_url` — the URL to use for image `src` attributes in Hugo
- `b2_bucket_name` / `b2_bucket_id` — for uploading photos via the B2 CLI
- `b2_application_key_id` / `b2_application_key` — read-only credentials (e.g. for CI)
