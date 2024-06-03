provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "pranav10697"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_iam_user_policy" "lb_ro" {
  name = "test"
  user = aws_iam_user.lb.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "*"
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_user" "ps" {
  name = "ps"
  path = "/"
}

resource "aws_iam_access_key" "lb" {
  user = aws_iam_user.lb.name

}
