resource "aws_ssm_parameter" "test1" {
  name  = var.parameters[0].name
  type  = var.parameters[0].value
  value = var.parameters[0].type
}

variable "parameters" {}
