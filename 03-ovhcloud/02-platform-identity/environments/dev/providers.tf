terraform {
  required_version = ">= 1.6"

  required_providers {
    ovh = {
      source  = "ovh/ovh"
      version = "~> 2.19"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

# Non-secret config is set in code; the secrets are supplied through environment
# variables (never hard-coded): OVH_APPLICATION_SECRET, OVH_CONSUMER_KEY
provider "ovh" {
  endpoint        = "ovh-eu"
  application_key = "REPLACE_WITH_OVH_APPLICATION_KEY"
}

provider "random" {}
