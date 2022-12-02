resource "aws_elastic_beanstalk_application" "deployer" {
  name        = "invoicer-deployer"
  description = "Securing DevOps Invoicer deployer"
}

data "aws_elastic_beanstalk_solution_stack" "docker" {
  most_recent = true

  name_regex = "64bit Amazon Linux.+Docker"
}

resource "aws_s3_bucket" "deployer" {
  bucket = "invoicer-deployer-eb-vn"
}

resource "aws_s3_object" "deployer" {
  bucket = aws_s3_bucket.deployer.id
  key    = "app-version.json"
  source = "app-version.json"
}

resource "aws_elastic_beanstalk_application_version" "deployer" {
  name        = "invoicer-deployer"
  application = "invoicer-deployer"

  bucket = aws_s3_bucket.deployer.id
  key    = aws_s3_object.deployer.id
}

resource "aws_elastic_beanstalk_environment" "deployer" {
  name                = "invoicer-deployer"
  application         = aws_elastic_beanstalk_application.deployer.name
  version_label       = aws_elastic_beanstalk_application_version.deployer.name
  solution_stack_name = data.aws_elastic_beanstalk_solution_stack.docker.name

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-service-role"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "AWS_ACCESS_KEY_ID"
    value     = "<your-aws-key>"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "AWS_SECRET_ACCESS_KEY"
    value     = "<your-aws-key>"
  }
}
