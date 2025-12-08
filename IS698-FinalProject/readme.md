# **AWS Scalable Web Application – Final Project**
*A Terraform, CloudFormation, EC2, RDS, Lambda, S3, API Gateway, and Boto3 Integration Project*

---

## 📌 Overview
This project demonstrates how to build and deploy a scalable web application on AWS using a mix of Infrastructure-as-Code and manual AWS services.

The system includes:
- VPC, subnets, route tables, and security groups (Terraform)
- EC2 instance hosting static and dynamic webpages (CloudFormation)
- RDS MySQL database integrated with EC2
- Auto Scaling Group with a Launch Template
- Lambda function triggered by S3 uploads
- API Gateway invoking Lambda
- AWS CLI and Python Boto3 scripts for AWS interaction

The goal is to build an end-to-end architecture that demonstrates deployment, automation, scaling, and cloud integration.

---

# 🚀 How to Deploy the Project

## **1. Deploy Networking (Terraform)**

Inside the `terraform/` folder:

```sh
terraform init
terraform plan
terraform apply
```

This creates:
- VPC
- Public & private subnets
- Internet Gateway + route tables
- Security groups

---

## **2. Deploy EC2 and RDS (CloudFormation)**

Upload templates in AWS Console → CloudFormation:

- `ec2.yaml` – launches EC2 with Apache + website
- `rds.yaml` – creates MySQL database

After EC2 launches, SSH in and set up your web files:

```sh
sudo yum install httpd php php-mysqli -y
sudo systemctl start httpd
sudo systemctl enable httpd
sudo nano /var/www/html/db-check.php
sudo nano /var/www/html/students.php
```

Insert your RDS endpoint and DB credentials in both files.

---

## **3. Insert Sample Data into RDS**

From EC2:

```sh
mysql -h <RDS-ENDPOINT> -u admin -p
```

Then run:

```sql
CREATE DATABASE studentsdb;
USE studentsdb;

CREATE TABLE students(
  id INT PRIMARY KEY,
  name VARCHAR(50)
);

INSERT INTO students VALUES
(1,'Kenny Adams'),
(2,'Sumanth Reddy');
```

View data at `students.php`.

---

## **4. Test Auto Scaling**

```sh
sudo amazon-linux-extras install epel -y
sudo yum install stress -y
stress --cpu 4 --timeout 120
```

The Auto Scaling Group should launch a new instance.

---

## **5. Lambda + S3 Logging**

- Upload Lambda function  
- Add an S3 event trigger  
- Upload a file to S3  

Check CloudWatch logs to confirm.

---

## **6. API Gateway → Lambda**

Steps:
1. Create REST API  
2. Add GET method  
3. Integrate with Lambda (proxy mode)  
4. Deploy to a stage  

Open the Invoke URL to view the response.

---

## **7. Python Boto3 Scripts**

Inside `boto3-scripts/` run:

```sh
python create_bucket.py
python list_instances.py
python metadata.py
python invoke_lambda.py
```

---

# 🧪 Useful AWS CLI Commands

```sh
aws ec2 describe-instances
aws ec2 describe-vpcs
aws s3 ls
aws lambda invoke --function-name <name> response.json
```

---

# 📸 Screenshots & Documentation

```
/IS698-FinalProject-Screenshots.pdf
/IS698-FinalProjectReport.pdf
```

---

# ✅ Requirements Completed

- Terraform VPC deployment  
- EC2 web server  
- RDS integration  
- Auto Scaling  
- S3 → Lambda logging  
- API Gateway  
- AWS CLI + Boto3 automation  
- Full documentation & architecture diagram  
