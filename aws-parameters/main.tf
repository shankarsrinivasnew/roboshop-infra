resource "aws_ssm_parameter" "test1" {
  name  = var.parameters["name"]
  type  = var.parameters["type"]
  value = var.parameters["value"]
}

variable "parameters" {}
