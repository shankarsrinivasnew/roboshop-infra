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
} */

module "docdbm" {
  source = "git::https://github.com/shankarsrinivasnew/tf-module-docdb.git"
  env    = var.env
  tags   = var.tags

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
}

module "rdsm" {
  source = "git::https://github.com/shankarsrinivasnew/tf-module-rds.git"
  env    = var.env
  tags   = var.tags

  subnet_ids = local.db_subnet_ids

  for_each                = var.rds
  engine                  = each.value["engine"]
  engine_version          = each.value["engine_version"]
  backup_retention_period = each.value["backup_retention_period"]
  preferred_backup_window = each.value["preferred_backup_window"]
  storage_encrypted       = each.value["storage_encrypted"]
  instance_count          = each.value["instance_count"]
  instance_class          = each.value["instance_class"]
}

module "elasticachem" {
  source = "git::https://github.com/shankarsrinivasnew/tf-module-elasticache.git"
  env    = var.env
  tags   = var.tags

  subnet_ids = local.db_subnet_ids

  for_each        = var.elasticache
  engine          = each.value["engine"]
  engine_version  = each.value["engine_version"]
  node_type       = each.value["node_type"]
  num_cache_nodes = each.value["num_cache_nodes"]
}

module "rabbitmqm" {
  source = "git::https://github.com/shankarsrinivasnew/tf-module-rabbitmq.git"
  env    = var.env
  tags   = var.tags

  subnet_ids = local.db_subnet_ids

  for_each      = var.rabbitmq
  instance_type = each.value["instance_type"]
}
