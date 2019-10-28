resource "docker_image" "wordpress_image" {
  name = "wordpress:latest"
}

resource "docker_image" "mysql_image" {
  name = "mysql:5.7"
}
