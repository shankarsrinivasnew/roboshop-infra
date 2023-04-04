data "aws_ami" "ownami" {
  most_recent = true
  name_regex  = "devops-practice-with-ansible"
  owners      = ["self"]
}

data "aws_ssm_parameter" "ssh_pass" {
  name = "${var.env}.ssh.pass"
}
