data "aws_caller_identity" "current" {}

data "aws_ami" "myami" {
  most_recent      = true
  name_regex       = "devops-practice-with-ansible"
  owners           = [data.aws_caller_identity.current.account_id]
}

resource "aws_instance" "myec2" {
    ami =  data.aws_ami.myami.image_id
    instance_type = var.type
    vpc_security_group_ids = [aws_security_group.allow_tls.id]
    tags = {
        Name = "${var.component}-${var.env}"
    }
}

resource "null_resource" "mynull_resource" {

    provisioner "remote-exec" {

      connection {
        host = aws_instance.myec2.public_ip
        user = "root"
        password = "DevOps321"
      }

      inline = [
        "ansible-pull -i localhost, -U https://github.com/shankarsrinivasnew/roboshop-ansible.git -e role_name=${var.component}"

      ]
      
    }

}

resource "aws_security_group" "allow_tls" {
  name        = "${var.component}-${var.env}"
  description = "Allow TLS inbound traffic"

  ingress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.component}-${var.env}"
  }
}

resource "aws_route53_record" "myr53" {
  zone_id = "Z0607165JC9NKEPWSMH2"
  name    = "${var.component}.sstech.store"
  type    = "A"
  ttl     = 30
  records = [aws_instance.myec2.private_ip]
}


variable "type" {
  
}

variable "component" {
  
}
variable "env" {
  
}

variable "password" {
  
}