# aws

This subdirectory contains code for infrastructure deployed with AWS.

## Infrastructure overview

### Defined services list
- Compute module:
    - **ALB** - Application Load Balancing
    - **ASG** - Auto Scaling Groups
    - **EC2** - Elastic Compute Cloud
    - **AWS Security Groups**
- Database module:
    - **RDS** - Relational Database Service
    - **AWS Security Groups**
- Networking module:
    - **VPC** - Virtual Private Cloud
    - **IGW** - Internet Gateway
    - **NAT Gateways**
    - **EIP** - Elastic IP
    - **Subnets**
    - **Route tables**
- Queue module:
    - **SQS** - Simple Queue Service

### Deployed infrastructure
- Networking module:
    - defines VPC and subnets for all used services (excluding SQS)
        - 3 public and 3 private subnets for Auto-scaled EC2 instances with ALB (one public and one private for each defined Availability Zone)
        - 2 private subnets in 2 AZs for RDS database
    - defines IGW for connection to ALB deployed in VPC
        - defines EIP for IGW
    - defines NAT Gateways and Route Tables for connections
- Compute module:
    - defines EC2 ASG that deploys instances with default `nginx` configuration which have restricted access through a security group
    - defines ALB with target group and listener and restricted access through security group
- Database module:
    - defines RDS instance (default: `postgres 11.5`) with a security group allowing access to DB port
- Queue module:
    - defines SQS queue with default parameters defined in `queue/variables.tf`