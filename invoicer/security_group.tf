resource "aws_security_group" "invoicer_db" {
  name        = "invoicer_db"
  description = "Invoicer database security group"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.tags
}
