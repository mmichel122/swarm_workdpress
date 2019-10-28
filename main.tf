resource "docker_service" "wordpress-service" {
  name = "wordpress"

  task_spec {
    container_spec {
      image = "${docker_image.wordpress_image.name}"

      secrets {
        secret_id   = "${docker_secret.mysql_root_password.id}"
        secret_name = "${docker_secret.mysql_root_password.name}"
        file_name   = "/run/secrets/${docker_secret.mysql_root_password.name}"
      }

      env = {
        WORDPRESS_DB_HOST     = "${var.mysql_network_alias}"
        WORDPRESS_DB_USER     = "${var.wordpress_db_username}"
        WORDPRESS_DB_PASSWORD = "${var.mysql_user_password}"
        WORDPRESS_DB_NAME     = "${var.wordpress_db_name}"
      }
    }
    networks = [
      "${docker_network.public_bridge_network.name}",
      "${docker_network.private_bridge_network.name}"
    ]
  }

  mode {
    replicated {
      replicas = 2
    }
  }

  endpoint_spec {
    ports {
      target_port    = "80"
      published_port = "${var.ext_port}"
    }
  }
}

resource "docker_service" "mysql-service" {
  name = "${var.mysql_network_alias}"

  task_spec {
    container_spec {
      image = "${docker_image.mysql_image.name}"

      secrets {
        secret_id   = "${docker_secret.mysql_root_password.id}"
        secret_name = "${docker_secret.mysql_root_password.name}"
        file_name   = "/run/secrets/${docker_secret.mysql_root_password.name}"
      }

      secrets {
        secret_id   = "${docker_secret.mysql_db_password.id}"
        secret_name = "${docker_secret.mysql_db_password.name}"
        file_name   = "/run/secrets/${docker_secret.mysql_db_password.name}"
      }

      env = {
        MYSQL_ROOT_PASSWORD_FILE = "${var.mysql_root_password}"
        MYSQL_USER               = "${var.wordpress_db_username}"
        MYSQL_PASSWORD_FILE      = "${var.mysql_user_password}"
        MYSQL_DATABASE           = "${var.wordpress_db_name}"
      }

      mounts {
        target = "/var/lib/mysql"
        source = "${docker_volume.mysql_data_volume.name}"
        type   = "volume"
      }
    }
    networks = ["${docker_network.private_bridge_network.name}"]
  }
}
