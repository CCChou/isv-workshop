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
  # RHEL 8
  default = "ami-051f0947e420652a9"
}

variable "instance_type" {
  # Free type
  default = "t3.2xlarge"
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

  tags = {
    Name = "ExampleAppServerInstance"
  }

  depends_on = [
    aws_default_vpc.default
  ]
}

resource "aws_key_pair" "app_server_keypair" {
  key_name   = "app_server"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCqVECZCCje2m7iPRBeNbds2Plf4d+iLheTttFqrBWJRO2h6/5hkF1O37FtZ6UhdMbRU251YLqpCCiPOtQgvtdeJ6uDfhWX19z0vDya25Z9HTyVJ71fcMvx5G30YbGlmeTtLnvqqi080OYUSpePIYZyOqpttNF2O4RaJ2aLzdhhasQArEZFROCteB2Ou9Pv0kM3h8ODKJGwJv2SVkTZbwq95/y9/44l9N2GfvrjShWQoztYdoXFb4LplNboOtpbJnHAwTU0BUgHDbfPirLA7ZGPfZ9kBRYGWMiOoN6ZOR9tQTNrWwGOcmAyjO0SLX9IwIN7gnHmvyh+bdJU6JD1rk1AWvtUJZS3Lt/hPTdLHmqXRQ8lBtUqXmTL8ww2YGx5uhjqtJclN4Iyv8rNYj0nRHZrZYYu9Lik6+f5GPP+DnA4WysX8RPU6SqUzypcr16Uy9O0cJZiezdrbeZczQQV/ajvSkE/Ys8DKauAxcCxG7wKiBvZ9xAhjVbuL6iU31jXOME= dennischou@dechou-mac"
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