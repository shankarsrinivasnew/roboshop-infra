locals {
  db_subnet_ids = tolist([module.myvpcm["main"].myoutsub_private["db-az1"].id,module.myvpcm["main"].myoutsub_private["db-az2"].id])
  app_subnet_ids = tolist([module.myvpcm["main"].myoutsub_private["app-az1"].id,module.myvpcm["main"].myoutsub_private["app-az2"].id])
  #web_subnet_ids = tolist([module.myvpcm["main"].myoutsub_private["web-az1"].id,module.myvpcm["main"].myoutsub_private["web-az2"].id])

  pub_subnets_ids = tolist([module.myvpcm["main"].myoutsub_public["public-az1"].id,module.myvpcm["main"].myoutsub_public["public-az2"].id])
}

