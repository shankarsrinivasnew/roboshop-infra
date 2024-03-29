env             = "prod"
bastion_cidr    = ["172.31.12.67/32"]
prometheus_cidr = ["172.31.7.2/32"]
dns_domain      = "sstech.store"

vpc = {
  main = {
    vpc_cidr = "10.255.0.0/16"

    public_subnets = {
      public-az1 = {
        name              = "public-az1"
        cidr_block        = "10.255.0.0/24"
        availability_zone = "us-east-1a"
      }

      public-az2 = {
        name              = "public-az2"
        cidr_block        = "10.255.1.0/24"
        availability_zone = "us-east-1b"
      }
    }

    private_subnets = {
      web-az1 = {
        name              = "web-az1"
        cidr_block        = "10.255.2.0/24"
        availability_zone = "us-east-1a"
      }

      web-az2 = {
        name              = "web-az2"
        cidr_block        = "10.255.3.0/24"
        availability_zone = "us-east-1b"
      }

      app-az1 = {
        name              = "app-az1"
        cidr_block        = "10.255.4.0/24"
        availability_zone = "us-east-1a"
      }

      app-az2 = {
        name              = "app-az2"
        cidr_block        = "10.255.5.0/24"
        availability_zone = "us-east-1b"
      }

      db-az1 = {
        name              = "db-az1"
        cidr_block        = "10.255.6.0/24"
        availability_zone = "us-east-1a"
      }

      db-az2 = {
        name              = "db-az2"
        cidr_block        = "10.255.7.0/24"
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
    allow_db_to_subnets     = "app"
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
    allow_db_to_subnets     = "app"

  }
}

elasticache = {
  main = {
    engine              = "redis"
    engine_version      = "6.x"
    num_cache_nodes     = 1
    node_type           = "cache.t3.micro"
    allow_db_to_subnets = "app"
  }
}

rabbitmq = {
  main = {
    instance_type       = "t3.small"
    allow_db_to_subnets = "app"
  }
}

alb = {
  public = {
    load_balancer_type = "application"
    internal           = false
    name               = "public"
    subnet_name        = "public"
    allow_cidr         = ["0.0.0.0/0"]
  }
  private = {
    load_balancer_type = "application"
    internal           = true
    name               = "private"
    subnet_name        = "app"
    allow_cidr         = ["10.255.2.0/24", "10.255.3.0/24", "10.255.4.0/24", "10.255.5.0/24"]
  }
}

apps = {
  catalogue = {
    component           = "catalogue"
    instance_type       = "t3.small"
    desired_capacity    = 2
    max_size            = 10
    min_size            = 2
    subnet_name         = "app"
    port_internal       = 8080
    allow_app_to_subnet = "app"
    alb                 = "private"
    listener_priority   = 10
    ssm_parameters      = ["docdb"]

  }
  cart = {
    component           = "cart"
    instance_type       = "t3.small"
    desired_capacity    = 2
    max_size            = 10
    min_size            = 2
    subnet_name         = "app"
    port_internal       = 8080
    allow_app_to_subnet = "app"
    alb                 = "private"
    listener_priority   = 11
    ssm_parameters      = ["elasticache"]
  }

  user = {
    component           = "user"
    instance_type       = "t3.small"
    desired_capacity    = 2
    max_size            = 10
    min_size            = 2
    subnet_name         = "app"
    port_internal       = 8080
    allow_app_to_subnet = "app"
    alb                 = "private"
    listener_priority   = 12
    ssm_parameters      = ["docdb", "elasticache"]


  }

  shipping = {
    component           = "shipping"
    instance_type       = "t3.large"
    desired_capacity    = 3
    max_size            = 10
    min_size            = 3
    subnet_name         = "app"
    port_internal       = 8080
    allow_app_to_subnet = "app"
    alb                 = "private"
    listener_priority   = 13
    ssm_parameters      = ["rds"]



  }
  payment = {
    component           = "payment"
    instance_type       = "t3.small"
    desired_capacity    = 2
    max_size            = 10
    min_size            = 2
    subnet_name         = "app"
    port_internal       = 8080
    allow_app_to_subnet = "app"
    alb                 = "private"
    listener_priority   = 14
    ssm_parameters      = []

  }
  dispatch = {
    component           = "dispatch"
    instance_type       = "t3.small"
    desired_capacity    = 2
    max_size            = 10
    min_size            = 2
    subnet_name         = "app"
    port_internal       = 8080
    allow_app_to_subnet = "app"
    alb                 = "private"
    listener_priority   = 15
    ssm_parameters      = []

  }
  frontend = {
    component           = "frontend"
    instance_type       = "t3.small"
    desired_capacity    = 2
    max_size            = 10
    min_size            = 2
    subnet_name         = "web"
    port_internal       = 80
    allow_app_to_subnet = "public"
    alb                 = "public"
    listener_priority   = 9
    ssm_parameters      = []


  }
}
