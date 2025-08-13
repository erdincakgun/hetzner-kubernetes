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
  name     = "${basename(get_terragrunt_dir())}"
  location = "${local.region}"
  ip_range = "10.0.0.0/16"
}