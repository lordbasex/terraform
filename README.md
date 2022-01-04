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
