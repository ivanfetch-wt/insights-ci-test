# This file sets values for Terraform variables.
# See the file inputs.tf for a description of all variables.
insights_org           = "testorg"
insights_api_token     = "YourOrgAPIToken"
# insights_url="https://staging.insights.fairwinds.com" # the default
insights_agent_version = "2.0.2"
num_insights_agents    = "2"
# This is optional, and used for the ubuntu user.
# You can still SSH in using your Github account - see below.
#ssh_public_key_filename   = "/Users/ifetch/.ssh/id_rsa.pub"
# To optionally limit IP addresses that can SSH to the EC2.
# allowed_ssh_cidrs = ["1.2.3.4/32"]
region            = "us-east-1"
ec2_instance_type = "t3.xlarge"
# Github users that will be created and allowed to SSH into the EC2.
# SSH public keys configured for the Github account will be populated on the EC2.
/* An example, usernames may need adjustment.
github_users = [
  "ivanfetch-fw",
  "rbren",     # Robert
  "tgirgin23", # Tim
  "tarynmartin",
  "vitorvezani",
  "jdesouza",   # James
  "makoscafee", # Barnie
  "mhoss019",   # Mahmoud
  "ddakoda",
  "katiekeel", # Katie
  "mggude",    # Grace
  "rwsweeney", # Rachel
]
*/

vpc_cidr             = "10.90.0.0/16"
aws_azs              = ["us-east-1a", "us-east-1b", "us-east-1d"]
public_subnet_cidrs  = ["10.90.0.0/24", "10.90.1.0/24", "10.90.2.0/24"]
private_subnet_cidrs = ["10.90.3.0/24", "10.90.4.0/24", "10.90.5.0/24"]
global_vpc_tags = {
  "Managed By" = "Terraform"
}
private_subnet_tags = {
  "kubernetes.io/cluster/xxx"       = "shared"
  "kubernetes.io/role/internal-elb" = "1"
}
public_subnet_tags = {
  "kubernetes.io/cluster/xxx" = "shared"
  "kubernetes.io/role/elb"    = "1"
}

aws_profile = ""
