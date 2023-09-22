

resource "aws_iam_role" "sftp_user" {
  name               = "sftp-user-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "transfer.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "sftp_user_policy" {
  name = "sftp-user-policy"
  role = aws_iam_role.sftp_user.id

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowListHomeDirectory",
            "Effect": "Allow",
            "Action": "s3:ListBucket",
            "Resource": "${aws_s3_bucket.bucket.arn}"
        },
        {
            "Sid": "AllowWriteToIn",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:DeleteObject"
            ],
            "Resource": [
                "${aws_s3_bucket.bucket.arn}/${var.username}/*"
            ]
        }
      ]
}
POLICY
}

resource "aws_transfer_user" "this" {
  server_id           = aws_transfer_server.sftp.id
  user_name           = var.username
  home_directory_type = "LOGICAL"

  home_directory_mappings {
    entry  = "/${var.username}"
    target = "/${aws_s3_bucket.bucket.id}/${var.username}"
  }

  role = aws_iam_role.sftp_user.arn
}

resource "aws_transfer_ssh_key" "this" {
  server_id = aws_transfer_server.sftp.id
  user_name = var.username
  body      = file("~/.ssh/id_rsa.pub")

  depends_on = [
    aws_transfer_user.this
  ]
}