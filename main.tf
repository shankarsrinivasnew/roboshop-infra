/* module "mymodule" {
    source = "./ec2"
    for_each =var.component
    type = each.value["type"]
    component = each.value["name"]
    env = var.env
    monitor = try( each.value["monitor"], false )
} */

module "myvpc" {
    source = "git::https://github.com/shankarsrinivasnew/tf-module-vpc.git"
    for_each =  var.vpc
    cidr_block = each.value["vpc_cidr"]
  
}