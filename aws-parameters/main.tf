resource "aws_ssm_parameter" "test1" {
  name  = var.parameters.name
  type  = var.parameters[0].type
  value = var.parameters[0].value
}

variable "parameters" {}
