resource "aws_ssm_parameter" "test1" {
  name  = var.parameters[0]
  type  = var.parameters[1]
  value = var.parameters[2]
}

variable "parameters" {}
