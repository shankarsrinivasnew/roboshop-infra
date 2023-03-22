locals {
  vpc = module.myvpcm["main"].public_subnets_r["db-az1"].id
}

