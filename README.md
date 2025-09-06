# Tailscale Exit Node on AWS with Terraform

This repository provides Terraform configuration to deploy lightweight AWS EC2 instances as [Tailscale](https://tailscale.com) Exit Nodes.  
It allows you to route your internet traffic through different AWS regions, effectively building your own VPN for regional access, privacy, or secure remote development.

---

## 🚀 Features
- Deploys Ubuntu EC2 instances with Tailscale installed.
- Automatically joins your Tailnet using an AuthKey.
- Configures the instance as a Tailscale Exit Node.
- Supports multi-region deployment (via multiple `tfvars` files).
- Minimal setup: ready to use in minutes.

---

## 📦 Prerequisites
- [Terraform](https://developer.hashicorp.com/terraform/downloads) installed locally.
- AWS account with an existing key pair.
- [Tailscale account](https://tailscale.com) and a reusable AuthKey.

---

## ⚙️ Setup

### 1. Clone this repo
```bash
git clone https://github.com/nerdyAlezF/tailscale-exit-aws.git
cd tailscale-exit-aws
```

### 2. Configure variables
Create a `terraform.tfvars` file and keep it **local only**:
```hcl
regions           = ["ap-northeast-1", "us-east-1", "eu-central-1"]      # AWS regions (e.g. Tokyo)
key_name          = "your-aws-keypair"    # Existing AWS key pair name
tailscale_authkey = "tskey-auth-xxxxxxxx" # Tailscale reusable auth key
```

### 3. Initialize Terraform
```bash
terraform init
```

### 4. Deploy the instance
```bash
terraform apply -auto-approve
```

Terraform will:
- Launch an Ubuntu EC2 instance in the chosen region.
- Install Tailscale automatically.
- Register the instance to your Tailnet.
- Advertise itself as an Exit Node.

### 5. Approve in Tailscale
1. Go to the [Tailscale Admin Console](https://login.tailscale.com/admin/machines).  
2. Approve the new EC2 instance.  
3. Enable it as an **Exit Node**.  

### 6. Connect from your device
On your laptop or phone with Tailscale installed:
- Open the Tailscale client.  
- Select **Use Exit Node → [your AWS instance name]**.  
- Confirm that your internet traffic is routed through AWS.  

### 7. Verify the connection
```bash
curl ifconfig.me
```
It should return the public IP of your AWS instance, confirming that traffic is routed through your Exit Node.

### 8. (Optional) Multi-region Deployment
You can create multiple `.tfvars` files for different regions, e.g.:
- `tokyo.tfvars`
- `us-east.tfvars`
- `frankfurt.tfvars`

Apply them separately:
```bash
terraform apply -var-file=tokyo.tfvars -auto-approve
terraform apply -var-file=us-east.tfvars -auto-approve
terraform apply -var-file=frankfurt.tfvars -auto-approve
```

Each instance will join your Tailnet and can be enabled as an Exit Node.

### 9. Cleanup
```bash
terraform destroy -auto-approve
```

---

## 📊 Architecture Diagram
```mermaid
flowchart LR
    Laptop -->|Tailscale| AWS_EC2
    AWS_EC2 -->|Exit Node| Internet
```

---

## ⚠️ Disclaimer
This project is intended for **educational and personal use only**.  
Please check and comply with your local laws and the terms of service of any platforms you access through this setup.  
The author assumes no liability for misuse of this project.

---

## 📜 License
MIT
