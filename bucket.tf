resource "aws_s3_bucket" "bucket" {
  bucket = "hung-smtp-bucket-1"
}
resource "aws_s3_bucket" "bucket2" {
  bucket = "hung-smtp-bucket-2"
}


resource "aws_s3_bucket_public_access_block" "bucket_access_block" {
  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
