## Securing Devops Terraform

Deploy Invoicer:
1. Follow this [document](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/iam-servicerole.html) to create `aws-elasticbeanstalk-service-role` before running Terraform
2. Replace `Image.Name` in `app-version.json` file with your Docker Image
3. Run Terraform code

```
$ cd invoicer
$ terraform init
$ terraform apply
```

Deployer Invoicer Deployer:
1. Replace `<your-aws-key>` in `elastic_beanstalk.tf` file with your AWS KEY
2. Replace `Image.Name` in `app-version.json` file with your Docker Image
3. Run Terraform code

```
$ cd invoicer
$ terraform init
$ terraform apply
```