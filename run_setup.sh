#!/bin/bash

set -e

IP=$(cd terraform && terraform output -raw instance_ip)

scp -i keys/minecraft-key -o StrictHostKeyChecking=no scripts/deploy_server.sh ubuntu@$IP:/home/ubuntu/deploy_server.sh
ssh -i keys/minecraft-key -o StrictHostKeyChecking=no ubuntu@$IP "chmod +x deploy_server.sh && sudo ./deploy_server.sh"

echo "[*] Minecraft setup complete. Server IP: $IP"

