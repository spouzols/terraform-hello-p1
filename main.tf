provider "aws" {
  version = "2.16.0"
  region  = "eu-west-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  name_regex  = "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"

  owners = ["099720109477"] # canonical

  filter {
    name = "state"
    values = ["available"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name = "hypervisor"
    values = ["xen"]
  }

  filter {
    name = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_security_group" "hello_world" {
  name_prefix = "hello-world-"
  description = "Hello world security group"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "hello_world" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.small"
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.hello_world.id]

  user_data = file("templates/user_data.tpl")

  tags = {
    Name = "hello-world"
  }
}
