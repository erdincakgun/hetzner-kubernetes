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
  subnets = {
    public-subnet = {
      ip_range = "10.0.0.0/24"
      type     = "cloud"
    }
    private-subnet = {
      ip_range = "10.0.1.0/24"
      type     = "cloud"
    }
  }
  routes = {
    route-first = {
      destination = "0.0.0.0/0"
      gateway     = "10.0.0.2"
    }
  }
}