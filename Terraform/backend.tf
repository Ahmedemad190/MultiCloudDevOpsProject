resource "aws_s3_bucket" "my_bucket-ivolve" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_versioning" "my_bucket_versioning" {
  bucket = aws_s3_bucket.my_bucket-ivolve.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "state-lock-ivolve" {
  name = var.dynamo-db-name
  billing_mode = "PAY_PER_REQUEST"
      hash_key     = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
}

