# Minecraft Server EC2 Setup

## Background

We will automate the deployment of a Minecraft server on AWS using two main tools:
- Terraform to provision AWS infrastructure (EC2 instance, SSH key, and security group)
- Bash scripts to SSH into the instance and install/configure Minecraft

Everything is done from your local machine — no AWS Console, no manual SSH. A single deploy script handles provisioning, configuration, and starting the Minecraft server.

## Requirements

- AWS Academy Learner Lab Credentials
- Install the Terraform CLI: [Install Terraform | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- Install the AWS CLI: [Installing or updating the latest version of the AWS CLI - AWS Command Line Interface](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

## Commands

### Copy AWS Credentials:

1. Copy AWS CLI from the "AWS Academy Learner Lab" Module under "AWS Details"
2. `mkdir ~/.aws/`
3. `vim ~/.aws/credentials`
4. Paste AWS CLI and save

### Get Files:

5. `cd ~`
6. `git clone https://github.com/olsr6/minecraft-server.git`
7. `cd minecraft-server/`

### SSH Keys

8. `mkdir keys`
9. `ssh-keygen -t rsa -b 4096 -f keys/minecraft-key`

### Setup Instance

10. `cd terraform`
11. `terraform init`
12. `terraform apply`

### Deploy Server

13. `cd ..`
14. `./run_setup.sh`

### Verify

15. `nmap -sV -Pn -p T:25565 <instance_public_ip>`

## How to Connect

1. Open Minecraft Java Edition
2. Go to multiplayer and connect to <instance_public_ip>:25565

## References
 - https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
 - https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
 - https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-build
 - https://aws.amazon.com/blogs/gametech/setting-up-a-minecraft-java-server-on-amazon-ec2/
 - https://jmcglock.substack.com/p/how-to-run-a-minecraft-server-on
