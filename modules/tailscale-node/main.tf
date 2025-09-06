resource "aws_instance" "tailscale_exit" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t4g.micro"
  key_name      = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              sysctl -w net.ipv4.ip_forward=1
              echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf
              iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
              curl -fsSL https://tailscale.com/install.sh | sh
              tailscale up --ssh --advertise-exit-node --authkey=${var.tailscale_authkey}
              EOF

  tags = {
    Name = "tailscale-exit-${var.region}"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-arm64-server-*"]
  }
}