resource "aws_key_pair" "insights-loadtest" {
  count           = var.ssh_public_key_filename == "" ? 0 : 1
  key_name_prefix = var.name_prefix
  public_key      = file(var.ssh_public_key_filename)
}
