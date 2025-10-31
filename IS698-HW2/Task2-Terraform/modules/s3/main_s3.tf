variable "bucket_name" {}
variable "table_name" {}
variable "hash_key" {}

# S3 Bucket
resource "aws_s3_bucket" "bucket" {
  bucket        = var.bucket_name
  force_destroy = true
  tags = { Name = "hw2-s3-bucket-216" }
}

# DynamoDB Table
resource "aws_dynamodb_table" "table" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = var.hash_key

  attribute {
    name = var.hash_key
    type = "S"
  }

  tags = { Name = "hw2-dynamodb-216" }
}

output "bucket_name" { value = aws_s3_bucket.bucket.bucket }
output "table_name"  { value = aws_dynamodb_table.table.name }

