data "aws_caller_identity" "current" {}

data "aws_ami" "myami" {
  most_recent      = true
  name_regex       = "devops-practice-with-ansible"
  owners           = [data.aws_caller_identity.current.account_id]
}