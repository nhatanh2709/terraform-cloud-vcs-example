provider "aws" {
  region = var.region
}
data "aws_ami" "ami" {
    most_recent = true
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }
    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"]
}

resource "aws_instance" "server" {
    ami = data.aws_ami.ami.id
    instance_type = "t3.micro"
    lifecycle {
        create_before_destroy = true
    }

    tags = {
        Name = "Server"
    }
}