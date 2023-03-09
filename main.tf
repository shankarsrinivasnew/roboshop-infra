module "mymodule" {
    source = "./ec2"
    for_each =var.component
    type = each.value["type"]
    component = each.value["name"]
    env = var.env
    monitor = try( each.value["monitor"], false )
}