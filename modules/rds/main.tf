resource "aws_db_instance" "default" {
  allocated_storage    = 5
  db_name              = "test"
  engine               = "postgres"
  instance_class       = "db.t3.micro"
  username             = "foo"
  password             = "foobarbaz"
  skip_final_snapshot  = true
  parameter_group_name = "default.postgres14"
  publicly_accessible = true
  vpc_security_group_ids = [var.vpc_security_group_id]
}
