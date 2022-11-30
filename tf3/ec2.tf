data "aws_ami" "ubuntu" {
  most_recent = true
  # THis is Canonical
  owners = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# A launch template is used to help the EC2 be scalable.
# E.G. use of name_prefix allows more than one of these stacks to run at the
# same time.
resource "aws_launch_template" "insights-loadtest" {
  name_prefix            = "${var.name_prefix}-"
  update_default_version = true
  image_id               = data.aws_ami.ubuntu.id
  instance_type          = var.ec2_instance_type
  iam_instance_profile {
    arn = aws_iam_instance_profile.insights-loadtest.arn
  }
  /*
  instance_market_options {
    market_type = "spot"
  }
*/
  user_data = base64gzip(templatefile("${path.module}/userdata.tmpl", {
    exchange_bucket_name   = aws_s3_bucket.data_exchange.id
    additional_users       = local.additional_users
    name_prefix            = var.name_prefix
    num_insights_agents    = var.num_insights_agents
    insights_agent_version = var.insights_agent_version
    insights_api_token     = var.insights_api_token
    insights_url           = var.insights_url
    insights_org           = var.insights_org
  }))
  key_name = var.ssh_public_key_filename != "" ? var.ssh_public_key_filename : (length(aws_key_pair.insights-loadtest) > 0 ? aws_key_pair.insights-loadtest[0].id : null)
}

resource "aws_instance" "insights-loadtest" {
  subnet_id                   = module.vpc.public_subnets[1] # This ends up selecting an AZ
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.ssh.id]
  launch_template {
    id      = aws_launch_template.insights-loadtest.id
    version = aws_launch_template.insights-loadtest.latest_version
  }
  tags = {
    Name       = var.name_prefix # names will not be unique per EC2
    created_by = "Terraform"
  }
  volume_tags = {
    Name       = var.name_prefix # names will not be unique per EC2
    created_by = "Terraform"
  }
  root_block_device {
    volume_type = "gp3"
    volume_size = "50"
  }
}

resource "aws_eip" "insights-loadtest-ip" {
  instance = aws_instance.insights-loadtest.id
  vpc      = true
}

output "insights_loadtest_public_ip" {
  value = aws_eip.insights-loadtest-ip.public_ip
}

