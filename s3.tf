resource "aws_s3_bucket" "i-One-test" {
  bucket = local.bucket-prefix
}

resource "random_string" "random-suffix" {
  length = 6
  special = false
  upper = false
}

variable "Project" {
    default = "i-one-test"
}

locals {
  bucket-prefix = "${var.Project}-${random_string.random-suffix.id}-bucket"
}