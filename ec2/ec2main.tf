resource "aws_instance" "myec2" {
    ami =  data.aws_ami.myami.image_id
    instance_type = var.type
    vpc_security_group_ids = [aws_security_group.allow_tls.id]
    iam_instance_profile = "${var.component}-${var.env}-profile"
    tags = {
      Name = "${var.component}-${var.env}"
      Monitor = var.monitor ? "yes" : "no"
    }
}

resource "null_resource" "mynull_resource" {
    depends_on = [aws_route53_record.myr53]
    provisioner "remote-exec" {

      connection {
        host = aws_instance.myec2.public_ip
        user = "root"
        password = "DevOps321"
      }

      inline = [
        "ansible-pull -i localhost, -U https://github.com/shankarsrinivasnew/roboshop-ansible.git roboshop.yml -e role_name=${var.component} -e env=${var.env}"

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
  name    = "${var.component}-${var.env}.sstech.store"
  type    = "A"
  ttl     = 30
  records = [aws_instance.myec2.private_ip]
}

resource "aws_iam_policy" "ssm_policy" {
  name        = "${var.component}-${var.env}-policy"
  path        = "/"
  description = "${var.component}-${var.env}-policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ssm:GetParameterHistory",
                "ssm:GetParametersByPath",
                "ssm:GetParameters",
                "ssm:GetParameter"
            ],
            "Resource": "arn:aws:ssm:us-east-1:334531533654:parameter/${var.env}.${var.component}*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "ssm:DescribeParameters",
            "Resource": "*"
        }
    ]
})
}

resource "aws_iam_role" "ssm_role" {
  name = "${var.component}-${var.env}-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
})
}

resource "aws_iam_instance_profile" "ssm_profile" {
  name = "${var.component}-${var.env}-profile"
  role = aws_iam_role.ssm_role.name
}

resource "aws_iam_role_policy_attachment" "ssm-attach" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = aws_iam_policy.ssm_policy.arn
}

/*variable "password" {
  
}*/

