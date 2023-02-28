data "aws_ami" "myami" {
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
  owners           = ["973714476881"]
}

resource "aws_instance" "myec2" {
    ami =  data.aws_ami.myami.image_id
    instance_type = var.type
    vpc_security_group_ids = ["aws_security_group.allow_tls.id"]
    tags = {
        Name = "${var.component}-${var.env}"
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
  records = ["aws_instance.myec2.private_ip"]
}


variable "type" {
  
}

variable "component" {
  
}
variable "env" {
  
}