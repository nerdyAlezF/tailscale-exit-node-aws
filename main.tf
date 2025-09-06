provider "aws" {
  alias  = "default"
  region = "ap-southeast-1" # fallback default
}

module "tailscale_exit_nodes" {
  source = "./modules/tailscale-node"
  for_each = toset(var.regions)

  region            = each.value
  key_name          = var.key_name
  tailscale_authkey = var.tailscale_authkey
}

output "exit_node_ips" {
  value = { for r, node in module.tailscale_exit_nodes : r => node.public_ip }
}
