resource "aws_db_instance" "default" {
  allocated_storage      = 5
  db_name                = var.DB_NAME
  engine                 = "postgres"
  instance_class         = "db.t3.micro"
  username               = var.DB_USER
  password               = var.DB_PASSWORD
  skip_final_snapshot    = true
  parameter_group_name   = "default.postgres14"
  publicly_accessible    = true
  vpc_security_group_ids = [var.vpc_security_group_id]
}
