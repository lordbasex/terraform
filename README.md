# Terraform - Infrastructure as code

# EC2 AMI AmazonLinux

## Install awscli
```
sudo su
rm -fr /usr/bin/aws
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install -i /usr/local/aws-cli -b /usr/local/bin -b /usr/bin
ln -s /usr/local/bin/aws  /usr/bin/aws
```

## Configure awscli
```
aws configure
aws sts get-caller-identity
```

## Install terraform and dependencies
```
sudo su
yum install -y yum-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
yum -y install terraform git
```

### Verify the installation
```
terraform -help
```

## Clone
```
cd /root
git clone https://github.com/lordbasex/terraform.git
```

## Step

### Step 00 - 01_s3 

```
cd /root/terraform/aws/00_step/01_s3/
```

```
cat > terraform.tfvars <<ENDLINE
project_name = "xxxxxxxxxx"
aws_region   = "us-east-1"
ENDLINE
```

```
terraform init
terraform plan
terraform apply
```

### Step 01 - 01_vpc 

```
cd /root/terraform/aws/01_step/01_vpc/
```

```
cat > terraform.tfvars <<ENDLINE
aws_region                 = "us-east-1"
project_name               = "vpc-xxxxxxxxxx"
environment                = "production"
vpc_cidr_block             = "172.31.0.0/16"
public_subnet_cidr_blocks  = ["172.31.1.0/24", "172.31.2.0/24", "172.31.3.0/24"]
private_subnet_cidr_blocks = ["172.31.31.0/24", "172.31.32.0/24", "172.31.33.0/24"]
intra_subnet_cidr_blocks   = ["172.31.61.0/24", "172.31.62.0/24", "172.31.63.0/24"]
enable_nat_gateway         = true
enable_vpn_gateway         = false
enable_dns_hostnames       = true
enable_dns_support         = true
ENDLINE
```

```
cat > terraform.backend.tfvars <<ENDLINE
bucket         = "terraform-remote-state-xxxxxxxxxx"
key            = "terraform/us-east-1/vpc/vpc.tfstate"
region         = "us-east-1"
encrypt        = true
dynamodb_table = "terraform-remote-state-lock-xxxxxxxxxx"
ENDLINE
```

```
terraform init -backend-config=terraform.backend.tfvars
terraform plan
terraform apply
```
