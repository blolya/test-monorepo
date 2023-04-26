variable "vpc_security_group_id" {}

variable "db_name" {
  type = string
  description = "Database name"
}

variable "db_user" {
  type = string
  description = "Database user name"
}

variable "db_password" {
  type = string
  description = "Database password"
}
