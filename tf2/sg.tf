resource "aws_security_group" "ssh" {
  name_prefix = "${var.name_prefix}-"
  description = "Allow inbound SSH"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidrs
  }


  vpc_id = module.vpc.vpc_id
}

