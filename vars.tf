variable "mysql_root_password" {
  description = "The MySQL root password."
  default     = "MTIzNDU2Cg=="
}

variable "mysql_user_password" {
  description = "The MySQL user password."
  default     = "MTIzNDU2Cg=="
}

variable "wordpress_db_username" {
  description = "Wordpress site database username."
  default     = "wordpress"
}

variable "wordpress_db_name" {
  description = "Ghost blog database name."
  default     = "wordpress"
}

variable "mysql_network_alias" {
  description = "The network alias for MySQL."
  default     = "db"
}

variable "wordpress_network_alias" {
  description = "The network alias for Ghost"
  default     = "wordpress"
}

variable "ext_port" {
  description = "The public port for wordpress"
}
