variable "region" {
  description = "AWS region"
  type        = string
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
