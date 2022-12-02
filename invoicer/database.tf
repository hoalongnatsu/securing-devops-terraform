resource "aws_db_subnet_group" "invoicer" {
  name       = "invoicer"
  subnet_ids = data.aws_subnets.subnets.ids

  tags = local.tags
}

resource "aws_db_instance" "invoicer" {
  allocated_storage = 5

  engine         = "postgres"
  engine_version = "10.17"
  instance_class = "db.t2.micro"
  identifier     = "invoicer"
  db_name        = "invoicer"
  username       = "invoicer"
  password       = "S0m3th1ngr4nd0m"

  db_subnet_group_name   = aws_db_subnet_group.invoicer.name
  vpc_security_group_ids = [aws_security_group.invoicer_db.id]

  skip_final_snapshot = true
  multi_az            = false
  publicly_accessible = true
  apply_immediately   = true

  tags = local.tags
}
