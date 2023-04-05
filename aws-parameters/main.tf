resource "aws_ssm_parameter" "test1" {
  count = length(var.parameters)
  name  = var.parameters[count.index].name
  type  = var.parameters[count.index].type
  value = var.parameters[count.index].value
}

variable "parameters" {}

resource "aws_ssm_parameter" "secret" {
  count = length(var.secrets)
  name  = var.secrets[count.index].name
  type  = var.secrets[count.index].type
  value = var.secrets[count.index].value
}

variable "secrets" {}

resource "aws_ssm_parameter" "jenkins_user" {
  name = "jenkins_user"
  type = "String"
  value = "admin"
}

resource "aws_ssm_parameter" "jenkins_pass" {
  name = "jenkins_pass"
  type = "SecureString"
  value = "admin123"
}