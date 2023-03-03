resource "aws_s3_bucket" "this" {
  bucket = var.s3_name
  tags   = var.tags
}


resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls = true
}

resource "aws_s3_bucket_versioning" "this" {
  count  = var.versioned ? 1 : 0
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_cors_configuration" "this" {
  bucket = aws_s3_bucket.this.bucket

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD", "PUT", "POST", "DELETE"]
    allowed_origins = ["*"]
    expose_headers = [
      "x-amz-server-side-encryption",
      "x-amz-server-request-id",
      "x-amz-server-id-2",
      "ETag"
    ]
    max_age_seconds = 3000
  }
}

data "aws_iam_policy_document" "otopad_s3_policy" {
  statement {
    sid     = "0"
    actions = ["s3:PutObject", "s3:GetObject"]
    resources = [
      "arn:aws:s3:::${var.s3_name}",
      "arn:aws:s3:::${var.s3_name}/*"
    ]
    principals {
      type        = "AWS"
      identifiers = var.allowed_identifier
    }
  }
}

resource "aws_s3_bucket_policy" "otopad_s3_bucket_policy" {
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.otopad_s3_policy.json
}
