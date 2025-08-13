include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  region_hcl = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  region     = local.region_hcl.locals.region
}

terraform {
  source = "tfr://registry.terraform.io/terraform-hetzner-modules/server/hetzner?version=1.0.0"
}

inputs = {
  image    = "ubuntu-22.04",
  name     = "${basename(get_terragrunt_dir())}"
  type     = "cx22"
  location = "${local.region}"
  networking = {
    ipv4_enabled = true
    ipv6_enabled = true
  }
}