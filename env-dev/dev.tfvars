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
      public-az1 = {
        name              = "public-az1"
        cidr_block        = "10.0.0.0/24"
        availability_zone = "us-east-1a"
      }

      public-az2 = {
        name              = "public-az2"
        cidr_block        = "10.0.1.0/24"
        availability_zone = "us-east-1b"
      }
    }

    private_subnets = {
      web-az1 = {
        name              = "web-az1"
        cidr_block        = "10.0.2.0/24"
        availability_zone = "us-east-1a"
      }

      web-az2 = {
        name              = "web-az2"
        cidr_block        = "10.0.3.0/24"
        availability_zone = "us-east-1b"
      }

      app-az1 = {
        name              = "app-az1"
        cidr_block        = "10.0.4.0/24"
        availability_zone = "us-east-1a"
      }

      app-az2 = {
        name              = "app-az2"
        cidr_block        = "10.0.5.0/24"
        availability_zone = "us-east-1b"
      }

      db-az1 = {
        name              = "db-az1"
        cidr_block        = "10.0.6.0/24"
        availability_zone = "us-east-1a"
      }

      db-az2 = {
        name              = "db-az2"
        cidr_block        = "10.0.7.0/24"
        availability_zone = "us-east-1b"
      }

    }

  }

}
