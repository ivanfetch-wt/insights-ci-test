locals {
  asset_filenames = [
    "infra.yaml",
    "insights-agent-template.yaml",
    "install-agents.sh",
  ]
}

resource "aws_s3_object" "assets" {
  count  = length(local.asset_filenames)
  bucket = aws_s3_bucket.data_exchange.id
  key    = element(local.asset_filenames, count.index)
  source = "../multiple-agents/${element(local.asset_filenames, count.index)}"
  etag   = filemd5("../multiple-agents/${element(local.asset_filenames, count.index)}")
}
