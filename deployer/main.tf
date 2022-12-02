provider "aws" {
  region  = "ap-southeast-1"
}

locals {
  tags = {
  }
}

data "aws_subnets" "subnets" {}

output "endpoint_url" {
  value = aws_elastic_beanstalk_environment.deployer.endpoint_url
}

output "id" {
  value = aws_elastic_beanstalk_environment.deployer.id
}

output "version_label" {
  value = aws_elastic_beanstalk_environment.deployer.version_label
}