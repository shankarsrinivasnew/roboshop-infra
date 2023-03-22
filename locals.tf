locals {
  db_subnet_ids = tolist([module.myvpcm["main"].myoutsub_private["db-az1"].id,module.myvpcm["main"].myoutsub_private["db-az2"].id])
}

