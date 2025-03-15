resource "aws_iam_policy" "ssh_key_access" {
  name        = "SSHKeyAccessPolicy"
  description = "Policy to allow access to the SSH key in Secrets Manager"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowSecretAccess"
        Effect    = "Allow"
        Action    = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource  = "arn:aws:secretsmanager:${var.aws_region}:${var.aws_account_id}:secret/${var.secret_name}*"
      }
    ]
  })
}

resource "aws_iam_user" "team_member" {
  name = "team-member"
}

resource "aws_iam_policy_attachment" "attach_policy_to_user" {
  name       = "AttachSSHKeyPolicy"
  users      = [aws_iam_user.team_member.name]
  policy_arn = aws_iam_policy.ssh_key_access.arn
}

output "ssh_key_retrieval_command" {
  value = "aws secretsmanager get-secret-value --secret-id ${var.secret_name} --query SecretString --output text > ~/.ssh/ec2-bastion-key-pair.pem && chmod 400 ~/.ssh/ec2-bastion-key-pair.pem"
}
