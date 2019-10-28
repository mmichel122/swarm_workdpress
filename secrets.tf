resource "docker_secret" "mysql_root_password" {
  name = "root_password"
  data = "${base64encode(var.mysql_root_password)}"
}

resource "docker_secret" "mysql_db_password" {
  name = "db_password"
  data = "${base64encode(var.mysql_user_password)}"
}
