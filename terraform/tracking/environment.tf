resource "vercel_project_environment_variable" "vercel_env" {
  for_each = local.vercel_environment_variables

  project_id = vercel_project.project.id
  key        = each.key
  value      = each.value
  target     = ["production"]
}