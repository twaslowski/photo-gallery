resource "vercel_project" "project" {
  name      = "umami-ycdk"
  framework = "nextjs"

  git_repository = {
    type = "github"
    repo = "twaslowski/umami"
  }

  automatically_expose_system_environment_variables = true
  enable_affected_projects_deployments = true
}
