output "public_ip" {
  value = aws_instance.tailscale_exit.public_ip
}
