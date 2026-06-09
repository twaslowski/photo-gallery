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

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name       | Version   |
|------------|-----------|
| terraform  | >= 1.14.0 |
| b2         | ~> 0.10   |
| cloudflare | ~> 5.0    |

## Providers

| Name       | Version |
|------------|---------|
| b2         | 0.12.1  |
| cloudflare | 5.19.0  |

## Modules

No modules.

## Resources

| Name                                                                                                                                  | Type     |
|---------------------------------------------------------------------------------------------------------------------------------------|----------|
| [b2_application_key.photos_readonly](https://registry.terraform.io/providers/Backblaze/b2/latest/docs/resources/application_key)      | resource |
| [b2_bucket.photos](https://registry.terraform.io/providers/Backblaze/b2/latest/docs/resources/bucket)                                 | resource |
| [cloudflare_dns_record.images](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record)        | resource |
| [cloudflare_dns_record.pages](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record)         | resource |
| [cloudflare_ruleset.bucket_rewrite](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/ruleset)      | resource |
| [cloudflare_ruleset.cache_rules_example](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/ruleset) | resource |

## Inputs

| Name                     | Description                                       | Type     | Default         | Required |
|--------------------------|---------------------------------------------------|----------|-----------------|:--------:|
| b2\_application\_key     | Backblaze B2 application key                      | `string` | n/a             |   yes    |
| b2\_application\_key\_id | Backblaze B2 application key ID                   | `string` | n/a             |   yes    |
| b2\_bucket\_name         | Name of the B2 bucket for web photos              | `string` | `"photos-web"`  |    no    |
| backblaze\_friendly\_url | Friendly Backblaze URL (e.g. f003.backblaze.com)  | `string` | n/a             |   yes    |
| cloudflare\_api\_token   | Cloudflare API token                              | `string` | n/a             |   yes    |
| cloudflare\_zone\_id     | Cloudflare Zone ID for your domain                | `string` | n/a             |   yes    |
| domain                   | The base domain (e.g. yourdomain.com)             | `string` | n/a             |   yes    |
| github\_username         | Your GitHub username (for Pages CNAME)            | `string` | n/a             |   yes    |
| images\_subdomain        | Subdomain for serving images from B2 (e.g. img)   | `string` | `"img"`         |    no    |
| site\_subdomain          | Subdomain for the gallery site (e.g. photography) | `string` | `"photography"` |    no    |

## Outputs

No outputs.
<!-- END_TF_DOCS -->