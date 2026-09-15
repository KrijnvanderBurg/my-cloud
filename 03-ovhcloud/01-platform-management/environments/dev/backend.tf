terraform {
  backend "s3" {
    bucket = "rg-tfstate-co-dev-par-01"
    region = "par"

    endpoints = {
      s3 = "https://s3.par.io.cloud.ovh.net"
    }

    use_path_style              = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
  }
}