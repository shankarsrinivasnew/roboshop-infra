/* module "mymodule" {
    source = "./ec2"
    for_each =var.component
    type = each.value["type"]
    component = each.value["name"]
    env = var.env
    monitor = try( each.value["monitor"], false )
} */

module "myvpcm" {
    source = "git::https://github.com/shankarsrinivasnew/tf-module-vpc.git"
    for_each =  var.vpc
    vpc_cidr = each.value["vpc_cidr"]
    env = var.env
    tags = var.tags
    public_subnets = each.value["public_subnets"]
    private_subnets = each.value["private_subnets"]
    default_vpc_id = var.default_vpc_id
    default_route_table = var.default_route_table
}

output "mylocalo" {
  value = local.vpc
}