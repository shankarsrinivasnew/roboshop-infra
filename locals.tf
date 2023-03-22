locals {
  vpc = module.myvpcm["main"].private_subnets["db-az1"].id
}

