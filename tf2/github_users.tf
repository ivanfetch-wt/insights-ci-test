locals {
  additional_users = flatten([
    for i, v in var.github_users : {
      login               = v
      supplemental_groups = "githubsudo,docker"
      authorized_keys     = element(data.http.githubkeys.*.body, i)
    }
  ])
}

data "http" "githubkeys" {
  count = length(var.github_users)
  url   = "https://github.com/${element(var.github_users, count.index)}.keys"
}
