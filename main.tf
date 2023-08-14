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

# # Create a new SSH key
# resource "equinix_metal_ssh_key" "key1" {
#   name       = "terraform-1"
#   public_key = file("/Users/xiaoxuancui/Documents/GitHub/equinix-terraform/keys/id_rsa.pub")
# }

variable "facilities" {
  type    = list(string)
  default = ["sv", "ny"]
}

# Create new device with "key1" included. The device resource "depends_on" the
# key, in order to make sure the key is created before the device.
resource "equinix_metal_device" "test" {
  count = length(var.facilities)
  hostname         = "test-device-${count.index}"
  plan             = "c3.small.x86"
  metro            = var.facilities[count.index]
  operating_system = "ubuntu_22_04"
  billing_cycle    = "hourly"
  project_id       = "b8dd41c7-1b01-4713-b0ea-c8e33e8c043d"
#   depends_on       = ["equinix_metal_ssh_key.key1"]
}
