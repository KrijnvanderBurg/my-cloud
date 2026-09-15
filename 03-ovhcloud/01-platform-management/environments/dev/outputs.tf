output "project" {
  description = "OVHcloud Public Cloud project used by this environment."
  value = {
    id          = data.ovh_cloud_project.platform_management.service_name
    description = data.ovh_cloud_project.platform_management.description
  }
}
