generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  backend "s3" {
    bucket         = "hetzner-kubernetes-tofu-state"
    key            = "${path_relative_to_include()}/tofu.tfstate"
    region         = "eu-central-1"
    use_lockfile   = true
  }
}
EOF
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
  }
}

variable "hcloud_token" {
  sensitive = true
}

provider "hcloud" {
  token = var.hcloud_token
}
EOF
}