parameters = [
  { name = "prod.frontend.catalogue_url", value = "http://catalogue-prod.sstech.store:80/", type = "String" },
  { name = "prod.frontend.user_url", value = "http://user-prod.sstech.store:80/", type = "String" },
  { name = "prod.frontend.cart_url", value = "http://cart-prod.sstech.store:80/", type = "String" },
  { name = "prod.frontend.shipping_url", value = "http://shipping-prod.sstech.store:80/", type = "String" },
  { name = "prod.frontend.payment_url", value = "http://payment-prod.sstech.store:80//", type = "String" },
  { name = "prod.cart.catalogue_host", value = "catalogue-prod.sstech.store", type = "String" },
  { name = "prod.cart.catalogue_port", value = "80", type = "String" },
  { name = "prod.catalogue.mongo", value = "true", type = "String" },
  { name = "prod.payment.cart_host", value = "cart-prod.sstech.store", type = "String" },
  { name = "prod.payment.cart_port", value = "80", type = "String" },
  { name = "prod.payment.user_host", value = "user-prod.sstech.store", type = "String" },
  { name = "prod.payment.user_port", value = "80", type = "String" },
  { name = "prod.payment.amqp_host", value = "rabbitmq-prod.sstech.store", type = "String" },
  { name = "prod.shipping.cart_endpoint", value = "cart-prod.sstech.store:80", type = "String" },
  { name = "prod.user.mongo", value = "true", type = "String" },
  { name = "prod.dispatch.amqp_host", value = "rabbitmq-prod.sstech.store", type = "String" }
]

secrets = [
  { name = "prod.payment.amqp_user", value = "roboshop", type = "SecureString" },
  { name = "prod.payment.amqp_pass", value = "roboshop123", type = "SecureString" },
  { name = "prod.rabbitmq.amqp_user", value = "roboshop", type = "SecureString" },
  { name = "prod.rabbitmq.amqp_pass", value = "roboshop123", type = "SecureString" },
  { name = "prod.dispatch.amqp_user", value = "roboshop", type = "SecureString" },
  { name = "prod.dispatch.amqp_pass", value = "roboshop123", type = "SecureString" },
  { name = "prod.docdb.user", value = "admin1", type = "SecureString" },
  { name = "prod.docdb.pass", value = "RoboShop1", type = "SecureString" },
  { name = "prod.rds.user", value = "admin1", type = "SecureString" },
  { name = "prod.rds.pass", value = "RoboShop1", type = "SecureString" },
  { name = "prod.ssh.pass", value = "DevOps321", type = "SecureString" }
]

/* { name = "dev.cart.redis_host", value = "redis-dev.sstech.store", type = "String" },
  { name = "dev.catalogue.mongo_url", value = "mongodb://mongodb-dev.sstech.store:27017/catalogue", type = "String" },
  { name = "dev.shipping.db_host", value = "mysql-dev.sstech.store", type = "String" }, 
  { name = "dev.user.redis_host", value = "redis-dev.sstech.store", type = "String" },
  { name = "dev.user.mongo_url", value = "mongodb://mongodb-dev.sstech.store:27017/users", type = "String" },
  { name = "dev.mysql.password", value = "RoboShop@1", type = "SecureString" } */

cicd = [
  { name = "jenkins_user", value = "admin", type = "String" },
  { name = "jenkins_pass", value = "admin123", type = "SecureString" },
  { name = "/sonarcube/sonar_user", value = "admin", type = "String" },
  { name = "/sonarcube/sonar_pass", value = "admin123", type = "SecureString" }
]



