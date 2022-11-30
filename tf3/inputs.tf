variable "name_prefix" {
  description = "A prefix used when naming EC2 instances and security groups, and the full name for other resources like the VPC."
  default     = "ifetch-insights-loadtest"
}

variable "ec2_instance_type" {
  description = "The EC2 instance type."
  default     = "t3.xlarge"
}

variable "github_users" {
  type        = list(string)
  description = "A list of Github usernames which will be created as SSH users on the EC2 instance. The SSH public keys will be fetched from Github and allowed to login to the respective SSH user."
}

variable "ssh_public_key_filename" {
  description = "The file name of a SSH public key, to populate an EC2 SSH keypair. This is optional, as long as github_users is populated with one or more Github users that are configured with SSH public keys."
  default     = ""
}

variable "allowed_ssh_cidrs" {
  type        = list(string)
  description = "A list of network CIDRs allowed to SSH into the EC2 instance."
  default = [
    "0.0.0.0/0"
  ]
}

variable "insights_agent_version" {
  description = "The Helm chart version of the Insights agent to install."
}

variable "num_insights_agents" {
  description = "The number of Insights agents to be installed in this single Kubernetes cluster."
}

variable "insights_api_token" {
  description = "An Insights API token with admin access to the Insights organization."
}

variable "insights_url" {
  description = "The URL for Insights."
  default     = "https://staging.insights.fairwinds.com"
}

variable "insights_org" {
  description = "The pre-existing Insights organization where clusters will be created."
}


variable "aws_azs" {
  type        = list(any)
  description = "A list of AWS availability zones to create network subnets."
}
variable "vpc_cidr" {
  description = "The network CIDR to be used for the VPC."
}
variable "public_subnet_cidrs" {
  type        = list(any)
  description = "A list of network CIDRs, within vpc_cidr, to use for public network subnets."
}
variable "private_subnet_cidrs" {
  type        = list(any)
  description = "A list of network CIDRs, within vpc_cidr, to use for private network subnets."
}
variable "global_vpc_tags" {
  default     = {}
  description = "A list of tags to be applied to all VPC related resources."
}
variable "private_subnet_tags" {
  type        = map(any)
  description = "A list of tags to be applied to private subnets"
  default     = {}
}
variable "public_subnet_tags" {
  type        = map(any)
  description = "A list of tags to be applied to public subnets"
  default     = {}
}
