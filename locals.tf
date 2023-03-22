locals {
  vpc = module.myvpcm["main"].myoutsub_private["db-az1"].id
}

