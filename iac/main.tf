terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "ssh_public_key" {
  type = string
}

provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_instance" "app_server" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = "app_server"
  vpc_security_group_ids = [aws_security_group.app_server_sg.id]
  user_data = file("${path.module}/setup.sh")

  root_block_device {
    volume_size = 120
  }

  tags = {
    Name = "ExampleAppServerInstance"
  }

  depends_on = [
    aws_default_vpc.default
  ]
}

resource "aws_key_pair" "app_server_keypair" {
  key_name   = "app_server"
  public_key = var.ssh_public_key
}

resource "aws_security_group" "app_server_sg" {
  name = "app_server_sg"

  ingress = [{
    description      = "Allow SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  },
  {
    description      = "Allow HTTP"
    from_port        = 8080
    to_port          = 8100
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }]

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "app_server_sg"
  }

  depends_on = [
    aws_default_vpc.default
  ]
}