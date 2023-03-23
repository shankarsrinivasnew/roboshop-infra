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

docdb = {
  main = {
    engine                  = "docdb"
    engine_version          = "4.0.0"
    backup_retention_period = 2
    preferred_backup_window = "07:00-09:00"
    skip_final_snapshot     = true
    storage_encrypted       = true
    instance_count          = 1
    instance_class          = "db.t3.medium"
  }
}

rds = {
  main = {
    engine                  = "aurora-mysql"
    engine_version          = "5.7.mysql_aurora.2.11.1"
    backup_retention_period = 1
    preferred_backup_window = "07:00-09:00"
    storage_encrypted       = true
    instance_count          = 1
    instance_class          = "db.t3.small"
  }
}

elasticache = {
  main = {
    engine          = "redis"
    engine_version  = "6.x"
    num_cache_nodes = 1
    node_type       = "cache.t3.micro"
  }
}

rabbitmq = {
  main = {
    instance_type = "t3.micro"
  }
}

alb = {
  public = {
    load_balancer_type = "application"
    internal           = true
    name               = "public"
    subnet_name        = "public"
  }
  private = {
    load_balancer_type = "application"
    internal           = false
    name               = "private"
    subnet_name        = "app"
  }
}
