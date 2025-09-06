variable "regions" {
  description = "List of AWS regions to deploy Tailscale Exit Nodes"
  type        = list(string)
}

variable "key_name" {
  description = "AWS key pair name for SSH"
  type        = string
}

variable "tailscale_authkey" {
  description = "Tailscale reusable auth key"
  type        = string
  sensitive   = true
}
