#!/bin/bash

set -e

sudo apt update && sudo apt upgrade -y

sudo apt install software-properties-common screen -y
sudo apt install openjdk-21-jdk -y

sudo mkdir -p /opt/minecraft
cd /opt/minecraft

sudo wget https://piston-data.mojang.com/v1/objects/e6ec2f64e6080b9b5d9b471b291c33cc7f509733/server.jar

sudo java -jar server.jar --nogui & sleep 10 && sudo pkill -f server.jar

echo 'eula=true' | sudo tee /opt/minecraft/eula.txt

sudo adduser --system --home /opt/minecraft minecraft || true
sudo groupadd minecraft || true
sudo adduser minecraft minecraft || true
sudo chown -R minecraft:minecraft /opt/minecraft

sudo tee /etc/systemd/system/minecraft.service > /dev/null <<EOF
[Unit]
Description=start and stop the minecraft-server

[Service]
WorkingDirectory=/opt/minecraft
User=minecraft
Group=minecraft
Restart=on-failure
RestartSec=20
ExecStart=/usr/bin/java -Xmx1G -Xms1G -jar server.jar --nogui

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable minecraft.service
sudo systemctl restart minecraft.service

echo "Minecraft server should be running."

