terraform {
  required_providers {
    equinix = {
      source = "equinix/equinix"
    }
  }
}

# Credentials for all Equinix resources
provider "equinix" {
  auth_token    = "7XgPoUXrz9RzfaD6i8gQBsiTYZxuBo4i"
}

# Create a new SSH key
resource "equinix_metal_ssh_key" "key1" {
  name       = "terraform-1"
  public_key = file("/keys/id_rsa.pub")
}

# Create new device with "key1" included. The device resource "depends_on" the
# key, in order to make sure the key is created before the device.
resource "equinix_metal_device" "test" {
  hostname         = "test-device"
  plan             = "c3.small.x86"
  metro            = "sv"
  operating_system = "ubuntu_22_04"
  billing_cycle    = "hourly"
  project_id       = local.project_id
  depends_on       = ["equinix_metal_ssh_key.key1"]
}