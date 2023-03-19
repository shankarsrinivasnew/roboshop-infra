/* component = {
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
} */

env = "dev"

vpc = {
  main = {
    vpc_cidr = "10.0.0.0/16"

    public_subnets = {
      public_az1 = {
        name              = "public_az1"
        cidr_block        = "10.0.0.0/24"
        availability_zone = "us-east-1a"
      }

      public_az2 = {
        name              = "public_az2"
        cidr_block        = "10.0.1.0/24"
        availability_zone = "us-east-1b"
      }
    }

    private_subnets = {
      web_az1 = {
        name              = "web_az1"
        cidr_block        = "10.0.2.0/24"
        availability_zone = "us-east-1a"
      }

      web_az2 = {
        name              = "web_az2"
        cidr_block        = "10.0.3.0/24"
        availability_zone = "us-east-1b"
      }

      app_az1 = {
        name              = "app_az1"
        cidr_block        = "10.0.4.0/24"
        availability_zone = "us-east-1a"
      }

      app_az2 = {
        name              = "app_az2"
        cidr_block        = "10.0.5.0/24"
        availability_zone = "us-east-1b"
      }

      db_az1 = {
        name              = "app_az1"
        cidr_block        = "10.0.6.0/24"
        availability_zone = "us-east-1a"
      }

      db_az2 = {
        name              = "app_az2"
        cidr_block        = "10.0.7.0/24"
        availability_zone = "us-east-1b"
      }

    }

  }

}
