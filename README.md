# Tailscale Exit Node on AWS with Terraform

This repository provides Terraform configuration to deploy lightweight AWS EC2 instances as [Tailscale](https://tailscale.com) Exit Nodes.  
It allows you to route your internet traffic through different AWS regions, effectively building your own VPN for regional access or enhanced privacy.

*This project is for educational and personal use only. Please check and comply with local regulations regarding VPN usage.*

---

## 🚀 Features
- Deploys Ubuntu EC2 instances with Tailscale installed.
- Automatically joins your Tailnet using an AuthKey.
- Configures the instance as a Tailscale Exit Node.
- Supports multi-region deployment (by providing different `tfvars` files).
- Minimal setup: ready to use in minutes.

---

## 📦 Prerequisites
- [Terraform](https://developer.hashicorp.com/terraform/downloads) installed locally.
- AWS account with an existing key pair.
- [Tailscale account](https://tailscale.com) and a reusable AuthKey.

---

## ⚙️ Setup

### 1. Clone this repo
```
bash
git clone https://github.com/nerdyAlezF/tailscale-exit-aws.git
cd tailscale-exit-aws
```

### 2. Configure variables

Create a terraform.tfvars file and keep in Local
```
region            = "ap-northeast-1"      # AWS region (e.g. Tokyo)
key_name          = "your-aws-keypair"    # Existing AWS key pair name
tailscale_authkey = "tskey-auth-xxxxxxxx" # Tailscale reusable auth key
```
### 3. Initialize Terraform & Deploy the Instance
```
terraform init
terraform apply -auto-approve
```

Terraform will:
Launch an Ubuntu EC2 instance in the chosen region.
Install Tailscale automatically.
Register the instance to your Tailnet.
Advertise itself as an Exit Node.

### 5. Approve in Tailscale
Go to the Tailscale Admin Console
Approve the new EC2 instance.
Enable it as an Exit Node.

6. Connect from your device
On your laptop or phone with Tailscale installed:
Open the Tailscale client.
Select Use Exit Node → [your AWS instance name].

Confirm that your internet traffic is routed through AWS.

7. Verify the connection
```
curl ifconfig.me
```
It should return the public IP of your AWS instance, confirming that traffic is routed through your Exit Node.

8. (Optional) Multi-region Deployment
You can create multiple .tfvars files for different regions, e.g.:
- tokyo.tfvars
- us-east.tfvars
- frankfurt.tfvars
Then, apply separately
```
terraform apply -var-file=tokyo.tfvars -auto-approve
terraform apply -var-file=us-east.tfvars -auto-approve
terraform apply -var-file=frankfurt.tfvars -auto-approve
```
Each instance will join your Tailnet and can be enabled as an Exit Node.

9. Cleanup
```
terraform destroy -auto-approve
```
