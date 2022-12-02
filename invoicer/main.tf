provider "aws" {
  region  = "ap-southeast-1"
}

locals {
  tags = {
    environment-name = "invoicer-api"
  }
}

data "aws_subnets" "subnets" {}

output "database" {
  value = {
    endpoint      = aws_db_instance.invoicer.endpoint
    database_name = aws_db_instance.invoicer.db_name
    username      = aws_db_instance.invoicer.username
  }
}

output "endpoint_url" {
  value = aws_elastic_beanstalk_environment.invoicer.endpoint_url
}

output "id" {
  value = aws_elastic_beanstalk_environment.invoicer.id
}

output "version_label" {
  value = aws_elastic_beanstalk_environment.invoicer.version_label
}