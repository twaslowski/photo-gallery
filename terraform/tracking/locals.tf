locals {
  vercel_environment_variables = {
    DATABASE_URL = var.database_url
    APP_SECRET   = ""
  }
}

ephemeral "random_password" "app_secret" {
  length = 32
}