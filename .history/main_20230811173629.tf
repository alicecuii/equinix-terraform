terraform {
  required_providers {
    equinix = {
      source = "equinix/equinix"
    }
  }
}

# Credentials for all Equinix resources
provider "equinix" {
  auth_token    = "someEquinixMetalToken"
}