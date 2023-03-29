/* module "mymodule" {
    source = "./ec2"
    for_each =var.component
    type = each.value["type"]
    component = each.value["name"]
    env = var.env
    monitor = try( each.value["monitor"], false )
} */

module "myvpcm" {
  source              = "git::https://github.com/shankarsrinivasnew/tf-module-vpc.git"
  for_each            = var.vpc
  vpc_cidr            = each.value["vpc_cidr"]
  env                 = var.env
  tags                = var.tags
  public_subnets      = each.value["public_subnets"]
  private_subnets     = each.value["private_subnets"]
  default_vpc_id      = var.default_vpc_id
  default_route_table = var.default_route_table
}

/* output "mylocalo" {
  value = local.db_subnet_ids
} 

 output "mylocalo2" {
  value = local.pub_subnets_ids
} 
 */

/* output "mylocalo3" {
   value = local.vpc_id
 } */

module "docdbm" {
  source = "git::https://github.com/shankarsrinivasnew/tf-module-docdb.git"
  env    = var.env
  tags   = var.tags
  vpc_id = module.myvpcm["main"].myoutvpcid

  subnet_ids = local.db_subnet_ids


  for_each                = var.docdb
  engine                  = each.value["engine"]
  engine_version          = each.value["engine_version"]
  backup_retention_period = each.value["backup_retention_period"]
  preferred_backup_window = each.value["preferred_backup_window"]
  skip_final_snapshot     = each.value["skip_final_snapshot"]
  storage_encrypted       = each.value["storage_encrypted"]
  instance_count          = each.value["instance_count"]
  instance_class          = each.value["instance_class"]
  allow_db_to_subnets     = lookup(local.subnet_cidr, each.value["allow_db_to_subnets"], null)
}

module "rdsm" {
  source = "git::https://github.com/shankarsrinivasnew/tf-module-rds.git"
  env    = var.env
  tags   = var.tags
  vpc_id = module.myvpcm["main"].myoutvpcid


  subnet_ids = local.db_subnet_ids

  for_each                = var.rds
  engine                  = each.value["engine"]
  engine_version          = each.value["engine_version"]
  backup_retention_period = each.value["backup_retention_period"]
  preferred_backup_window = each.value["preferred_backup_window"]
  storage_encrypted       = each.value["storage_encrypted"]
  instance_count          = each.value["instance_count"]
  instance_class          = each.value["instance_class"]
  allow_db_to_subnets     = lookup(local.subnet_cidr, each.value["allow_db_to_subnets"], null)


}

module "elasticachem" {
  source = "git::https://github.com/shankarsrinivasnew/tf-module-elasticache.git"
  env    = var.env
  tags   = var.tags
  vpc_id = module.myvpcm["main"].myoutvpcid


  subnet_ids = local.db_subnet_ids

  for_each            = var.elasticache
  engine              = each.value["engine"]
  engine_version      = each.value["engine_version"]
  node_type           = each.value["node_type"]
  num_cache_nodes     = each.value["num_cache_nodes"]
  allow_db_to_subnets = lookup(local.subnet_cidr, each.value["allow_db_to_subnets"], null)

}

module "rabbitmqm" {
  source = "git::https://github.com/shankarsrinivasnew/tf-module-rabbitmq.git"
  env    = var.env
  tags   = var.tags
  vpc_id = module.myvpcm["main"].myoutvpcid

  bastion_cidr = var.bastion_cidr
  dns_domain   = var.dns_domain


  subnet_ids = local.db_subnet_ids

  for_each            = var.rabbitmq
  instance_type       = each.value["instance_type"]
  allow_db_to_subnets = lookup(local.subnet_cidr, each.value["allow_db_to_subnets"], null)
}

module "albm" {
  source = "git::https://github.com/shankarsrinivasnew/tf-module-alb.git"
  env    = var.env
  tags   = var.tags
  vpc_id = module.myvpcm["main"].myoutvpcid


  for_each = var.alb

  name               = each.value["name"]
  load_balancer_type = each.value["load_balancer_type"]
  internal           = each.value["internal"]
  subnets            = lookup(local.lb_subnet_ids, each.value["subnet_name"], null)
  allow_cidr         = each.value["allow_cidr"]

}

module "asgm" {
  source       = "git::https://github.com/shankarsrinivasnew/tf-module-app.git"
  env          = var.env
  tags         = var.tags
  bastion_cidr = var.bastion_cidr
  dns_domain   = var.dns_domain

  vpc_id = module.myvpcm["main"].myoutvpcid

  for_each = var.apps

  component         = each.value["component"]
  instance_type     = each.value["instance_type"]
  desired_capacity  = each.value["desired_capacity"]
  max_size          = each.value["max_size"]
  min_size          = each.value["min_size"]
  port_internal     = each.value["port_internal"]
  listener_priority = each.value["listener_priority"]
  ssm_parameters    = each.value["ssm_parameters"]

  subnets             = lookup(local.asg_subnet_ids, each.value["subnet_name"], null)
  allow_app_to_subnet = lookup(local.subnet_cidr, each.value["allow_app_to_subnet"], null)
  alb_dns_name        = lookup(lookup(lookup(module.albm, each.value["alb"], null), "myalbout", null), "dns_name", null)
  listener_arn        = lookup(lookup(lookup(module.albm, each.value["alb"], null), "myalblistenerout", null), "arn", null)
}

/* output "alb" {
  value = module.albm
} */

/* output "redis" {
  value = module.elasticachem
  
} */
