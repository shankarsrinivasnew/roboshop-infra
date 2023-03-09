component = {
  frontend = {
    name = "frontend"
    type = "t3.micro"
    monitor = "true"
  }
  mongodb = {
    name = "mongodb"
    type = "t3.micro"
  }
  redis = {
    name = "redis"
    type = "t3.micro"
  }
  mysql = {
    name = "mysql"
    type = "t3.micro"
    monitor = "true"

  }
  user = {
    name = "user"
    type = "t3.micro"
    monitor = "true"

  }
  catalogue = {
    name = "catalogue"
    type = "t3.micro"
    monitor = "true"

  }
  cart = {
    name = "cart"
    type = "t3.micro"
    monitor = "true"

  }
  shipping = {
    name = "shipping"
    type = "t3.micro"
    monitor = "true"

  }
  rabbitmq = {
    name = "rabbitmq"
    type = "t3.micro"
  }
  payment = {
    name = "payment"
    type = "t3.micro"
    monitor = "true"

  }
  dispatch = {
    name = "dispatch"
    type = "t3.micro"
    monitor = "true"


  }
}

env = "dev"
