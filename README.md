# photography blog

This repository provides a really easy way to host your own image gallery/photography blog.
It works with GitHub Pages, Backblaze B2 and Cloudflare. The Hugo static site generator is used to create the gallery.

## Creating Posts

Posts are added at `content/posts`, as per Hugo convention.
Images can be referenced via the `img` macro, which resolves to the bucket base url defined in
`params.imageBaseURL`.

## Syncing images

Images are stored in the `images` directory by default. From there, they are synced to B2.
The Taskfile provides macros for these actions.

## Infrastructure

All infrastructure is managed via Terraform in the `terraform/` directory. It provisions:

- **Backblaze B2** — a public bucket for web-optimized photos with CORS rules and a read-only application key
- **Cloudflare DNS** — CNAME records pointing your domain to GitHub Pages and an images subdomain to B2
- **Cloudflare Cache** — aggressive edge/browser caching for image assets (leverages the Cloudflare ↔ B2 Bandwidth
  Alliance for free egress)

