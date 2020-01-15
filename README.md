# iac-bright
Infrastructure as code repository setting up AWS infrastructure.

## Contents
```
.                # Root directory with README and .gitignore
|-infrastructure # general directory for all infrastracture as code
|--aws           # AWS infrastructure as code
|-sample-app     # code for a sample node.js application for deployment (empty)
```

To see more information about infrastructure see the `README.md` file in `infrastructure/` subdirectory - (https://github.com/Blackweather/iac-bright/tree/master/infrastructure)

To see more information about AWS infrastructure see the `README.md` file in `infrastructure/aws/` subdirectory - (https://github.com/Blackweather/iac-bright/tree/master/infrastructure/aws)

## Prerequisites
- Terraform 0.12.19 installed (installation guide: https://learn.hashicorp.com/terraform/getting-started/install.html)
- programatic access to account with administrative permissions on AWS (use keys on your own account or create an IAM user terraform with programmatic access using this guide: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html)

## Running the code
- authenticate with AWS - find your `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` (more info: https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html), run these commands in your terminal:
```
export AWS_ACCESS_KEY_ID=<YOUR_AWS_ACCESS_KEY_ID>
export AWS_SECRET_ACCESS_KEY=<YOUR_AWS_SECRET_ACCESS_KEY>
```
- initialize the terraform modules and providers
```
cd infrastructure/aws/
terraform init
```
- validate the infrastructure code
```
terraform validate
```
- create a creation plan (make sure to check what is going to be created)
```
terraform plan -out=tfplan
```
- apply the infrastructure plan
```
terraform apply tfplan
```

### Optional: Destroy the infrastructure
- show a destruction plan (make sure to check what is going to be destroy)
```
terraform plan -destroy
```
- destroy the infrastructure
```
terraform destroy
```