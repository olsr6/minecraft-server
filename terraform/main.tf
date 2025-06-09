provider "aws" {
  region = "us-west-2"
}

resource "aws_key_pair" "minecraft_key" {
  key_name   = "minecraft-key"
  public_key = file("${path.module}/../keys/minecraft-key.pub")
}

resource "aws_security_group" "minecraft_security_group" {
  name = "minecraft_security_group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "minecraft" {
  ami           = "ami-0a605bc2ef5707a18"
  instance_type = "t3.small"
  key_name      = aws_key_pair.minecraft_key.key_name
  vpc_security_group_ids = [aws_security_group.minecraft_security_group.id]

  tags = {
    Name = "Minecraft Server"
  }
}

output "instance_ip" {
  value = aws_instance.minecraft.public_ip
}

