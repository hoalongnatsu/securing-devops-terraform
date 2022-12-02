resource "aws_elastic_beanstalk_application" "invoicer" {
  name        = "invoicer"
  description = "Securing DevOps Invoicer application"
}

data "aws_elastic_beanstalk_solution_stack" "docker" {
  most_recent = true

  name_regex = "64bit Amazon Linux.+Docker"
}

resource "aws_s3_bucket" "invoicer" {
  bucket = "invoicer-eb-vn"
}

resource "aws_s3_object" "invoicer" {
  bucket = aws_s3_bucket.invoicer.id
  key    = "app-version.json"
  source = "app-version.json"
}

resource "aws_elastic_beanstalk_application_version" "invoicer" {
  name        = "invoicer-api"
  application = "invoicer"

  bucket = aws_s3_bucket.invoicer.id
  key    = aws_s3_object.invoicer.id
}

resource "aws_elastic_beanstalk_environment" "invoicer" {
  name                = "invoicer-api"
  application         = aws_elastic_beanstalk_application.invoicer.name
  version_label       = aws_elastic_beanstalk_application_version.invoicer.name
  solution_stack_name = data.aws_elastic_beanstalk_solution_stack.docker.name

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-service-role" # You need to create role by manual
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "INVOICER_USE_POSTGRES"
    value     = "yes"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "INVOICER_POSTGRES_USER"
    value     = "invoicer"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "INVOICER_POSTGRES_PASSWORD"
    value     = aws_db_instance.invoicer.password
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "INVOICER_POSTGRES_DB"
    value     = "invoicer"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "INVOICER_POSTGRES_HOST"
    value     = aws_db_instance.invoicer.endpoint
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "INVOICER_POSTGRES_SSLMODE"
    value     = "disable"
  }
}
