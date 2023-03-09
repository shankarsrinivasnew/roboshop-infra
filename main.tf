module "mymodule" {
    source = "./ec2"
    for_each =var.component
    type = each.value["type"]
    component = each.value["name"]
    env = var.env
    monitor = try(var.each["monitor"], "false" )
    
    # password = try(each.value["password"], "null")
}