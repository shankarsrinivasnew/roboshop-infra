module "mymodule" {
    source = "./ec2"
    for_each =var.component
    type = each.value["type"]
    component = each.value["name"]
    env = "development"
    # password = try(each.value["password"], "null")
}