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
  depends_on = [module.myvpcm]
  source     = "git::https://github.com/shankarsrinivasnew/tf-module-rabbitmq.git"
  env        = var.env
  tags       = var.tags
  vpc_id     = module.myvpcm["main"].myoutvpcid

  bastion_cidr = var.bastion_cidr
  dns_domain   = var.dns_domain


  subnet_ids = local.db_subnet_ids

  for_each            = var.rabbitmq
  instance_type       = each.value["instance_type"]
  allow_db_to_subnets = lookup(local.subnet_cidr, each.value["allow_db_to_subnets"], null)
}

/*module "albm" {
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
  depends_on      = [module.myvpcm, module.docdbm, module.rdsm, module.elasticachem, module.albm, module.rabbitmqm]
  source          = "git::https://github.com/shankarsrinivasnew/tf-module-app.git"
  env             = var.env
  tags            = var.tags
  bastion_cidr    = var.bastion_cidr
  prometheus_cidr = var.prometheus_cidr
  dns_domain      = var.dns_domain

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
} */

/* output "alb" {
  value = module.albm
} */

/* output "redis" {
  value = module.elasticachem
  
} */

# Below is Load runner , install roboshop-load-gen from tools


/* resource "aws_spot_instance_request" "load-runnerr" {
  depends_on             = [module.myvpcm]
  ami                    = data.aws_ami.ownami.image_id
  instance_type          = "t3.medium"
  wait_for_fulfillment   = true
  subnet_id              = "subnet-0ae39aa246d2fe8a4"
  vpc_security_group_ids = ["sg-07b838b130d44ebf7"]

  tags = merge(
    var.tags,
    { Name = "${var.env}-load-runner" }
  )

}

resource "null_resource" "load-runner" {
  depends_on = [module.myvpcm, aws_spot_instance_request.load-runnerr]
  triggers = {
    abc = aws_spot_instance_request.load-runnerr.public_ip
  }

  provisioner "remote-exec" {
    connection {
      host     = aws_spot_instance_request.load-runnerr.public_ip
      user     = "root"
      password = data.aws_ssm_parameter.ssh_pass.value
    }
    inline = [
      "curl -s -L https://get.docker.com | bash",
      "systemctl enable docker",
      "systemctl start docker",
      "docker pull robotshop/rs-load",
      "set-hostname load-runner"
    ]

  }
}

resource "aws_ec2_tag" "name-tag" {
  resource_id = aws_spot_instance_request.load-runnerr.spot_instance_id
  key         = "Name"
  value       = "load-runner-${var.env}"

} */

/* module "minikube" {
  source = "github.com/scholzj/terraform-aws-minikube"

  aws_region        = "us-east-1"
  cluster_name      = "minikube"
  aws_instance_type = "t3.medium"
  ssh_public_key    = "~/.ssh/id_rsa.pub"
  aws_subnet_id     = lookup(local.lb_subnet_ids, "public", null)[0]
  //ami_image_id        = data.aws_ami.ami.id
  hosted_zone         = "sstech.store"
  hosted_zone_private = false

  tags = {
    Application = "Minikube"
  }

  addons = [
    "https://raw.githubusercontent.com/scholzj/terraform-aws-minikube/master/addons/storage-class.yaml",
    "https://raw.githubusercontent.com/scholzj/terraform-aws-minikube/master/addons/heapster.yaml",
    "https://raw.githubusercontent.com/scholzj/terraform-aws-minikube/master/addons/dashboard.yaml",
    "https://raw.githubusercontent.com/scholzj/terraform-aws-minikube/master/addons/external-dns.yaml"
  ]
}

output "MINIKUBE_SERVER" {
  value = "ssh centos@${module.minikube.public_ip}"
}

output "KUBE_CONFIG" {
  value = "scp centos@${module.minikube.public_ip}:/home/centos/kubeconfig ~/.kube/config"
} */

module "eks" {
  source             = "github.com/r-devops/tf-module-eks"
  ENV                = var.env
  PRIVATE_SUBNET_IDS = lookup(local.lb_subnet_ids, "app", null)
  PUBLIC_SUBNET_IDS  = lookup(local.lb_subnet_ids, "public", null)
  DESIRED_SIZE       = 1
  MAX_SIZE           = 1
  MIN_SIZE           = 1
}