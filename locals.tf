locals {

  db_subnet_ids = tolist([module.myvpcm["main"].myoutsub_private["db-az1"].id, module.myvpcm["main"].myoutsub_private["db-az2"].id])
  #app_subnet_ids = tolist([module.myvpcm["main"].myoutsub_private["app-az1"].id, module.myvpcm["main"].myoutsub_private["app-az2"].id])
  #web_subnet_ids = tolist([module.myvpcm["main"].myoutsub_private["web-az1"].id,module.myvpcm["main"].myoutsub_private["web-az2"].id])

  lb_subnet_ids = {
    public = tolist([module.myvpcm["main"].myoutsub_public["public-az1"].id, module.myvpcm["main"].myoutsub_public["public-az2"].id])
    app    = tolist([module.myvpcm["main"].myoutsub_private["app-az1"].id, module.myvpcm["main"].myoutsub_private["app-az2"].id])
  }

  asg_subnet_ids = {
    app = tolist([module.myvpcm["main"].myoutsub_private["app-az1"].id, module.myvpcm["main"].myoutsub_private["app-az2"].id])
    web = tolist([module.myvpcm["main"].myoutsub_private["web-az1"].id, module.myvpcm["main"].myoutsub_private["web-az2"].id])
  }

  subnet_cidr = {
    app    = tolist([module.myvpcm["main"].myoutsub_private["app-az1"].cidr_block, module.myvpcm["main"].myoutsub_private["app-az2"].cidr_block])
    public = tolist([module.myvpcm["main"].myoutsub_public["public-az1"].cidr_block, module.myvpcm["main"].myoutsub_public["public-az2"].cidr_block])
  }

}
