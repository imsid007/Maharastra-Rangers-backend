# Terraform Infrastructure for Maharastra Rangers Backend

Multi-environment Terraform configuration for deploying the Node.js Express backend on AWS.

## Directory Structure

```
terraform/
├── environments/
│   ├── dev/                    # Development environment
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── terraform.tfvars
│   └── prod/                   # Production environment
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── terraform.tfvars
└── modules/
    ├── infrastructure/         # Wrapper module for all resources
    ├── alb/                    # Application Load Balancer
    ├── codebuild/              # CodeBuild project
    ├── codepipeline/           # CI/CD pipeline
    ├── codestar-connection/    # GitHub connection
    ├── ec2/                    # EC2 instance
    ├── iam/                    # IAM roles and policies
    ├── secrets-manager/        # Environment variables
    └── vpc/                    # VPC and networking
```

## Quick Start

### Deploy Production

```bash
cd terraform/environments/prod
terraform init
terraform plan
terraform apply
```

### Deploy Development

```bash
cd terraform/environments/dev
terraform init
terraform plan
terraform apply
```

## Environment Differences

| Setting | Dev | Prod |
|---------|-----|------|
| Instance Type | t3.micro | t3.small |
| VPC CIDR | 10.1.0.0/16 | 10.0.0.0/16 |
| GitHub Branch | develop | main |
| NODE_ENV | development | production |

## Configuration

Edit the `terraform.tfvars` file in each environment directory:

```hcl
# environments/prod/terraform.tfvars

github_owner  = "Apjpawar"
github_repo   = "Maharastra-Rangers-backend"
github_branch = "main"

app_secrets = {
  MONGODB_URI = "mongodb+srv://..."
  JWT_SECRET  = "your-secret"
  NODE_ENV    = "production"
}
```

## Post-Deployment Steps

### 1. Activate CodeStar Connection

The CodeStar connection is created in PENDING status. Activate it:

1. Go to **AWS Console → Developer Tools → Connections**
2. Find the connection (e.g., `maharastra-rangers-prod-github-connection`)
3. Click **"Update pending connection"**
4. Authorize GitHub access

### 2. Configure GoDaddy DNS

After deployment, get the ALB DNS name from outputs:

```bash
terraform output alb_dns_name
```

Create a CNAME record in GoDaddy:
- **Type**: CNAME
- **Name**: api (or your subdomain)
- **Value**: `<alb_dns_name>`

### 3. Access EC2 Instance

Use SSM Session Manager (no SSH key needed):

```bash
aws ssm start-session --target <instance-id> --region ap-south-1
```

## State Management

For team collaboration, uncomment the S3 backend in each environment's `main.tf`:

```hcl
backend "s3" {
  bucket         = "maharastra-rangers-terraform-state"
  key            = "prod/terraform.tfstate"  # or "dev/terraform.tfstate"
  region         = "ap-south-1"
  encrypt        = true
  dynamodb_table = "terraform-state-lock"
}
```

Create the S3 bucket and DynamoDB table first:

```bash
aws s3 mb s3://maharastra-rangers-terraform-state --region ap-south-1
aws dynamodb create-table \
  --table-name terraform-state-lock \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region ap-south-1
```

## Destroy Infrastructure

```bash
# Destroy dev
cd terraform/environments/dev
terraform destroy

# Destroy prod
cd terraform/environments/prod
terraform destroy
```

## Cost Estimation (per environment)

| Resource | Dev (~) | Prod (~) |
|----------|---------|----------|
| EC2 | $8/mo | $15/mo |
| ALB | $20/mo | $20/mo |
| NAT Gateway | $35/mo | $35/mo |
| Secrets Manager | $0.40/mo | $0.40/mo |
| **Total** | **~$65/mo** | **~$70/mo** |
