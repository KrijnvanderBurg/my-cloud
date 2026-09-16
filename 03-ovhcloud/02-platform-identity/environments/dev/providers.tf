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

# Credentials are supplied through environment variables (never hard-coded):
#   OVH_ENDPOINT, OVH_APPLICATION_KEY, OVH_APPLICATION_SECRET, OVH_CONSUMER_KEY
provider "ovh" {}

provider "random" {}
