variable "vpc_security_group_id" {}

variable "DB_NAME" {
  type = string
  description = "Database name"
}

variable "DB_USER" {
  type = string
  description = "Database user name"
}

variable "DB_PASSWORD" {
  type = string
  description = "Database password"
}
