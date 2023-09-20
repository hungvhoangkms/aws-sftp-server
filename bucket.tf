resource "aws_s3_bucket" "bucket" {
  bucket        = "hung-smtp-bucket"
}

resource "aws_s3_bucket_public_access_block" "bucket_access_block" {
  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
resource "aws_s3_object" "folder_hung" {
    bucket = aws_s3_bucket.bucket.id
    acl    = "private"
    key    = "${var.username}/"
}