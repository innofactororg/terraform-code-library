locals {
  github = merge(
    var.github,
    {
      github_membership   = var.github_membership
      github_teams        = var.github_teams
      github_repositories = var.github_repositories
    }
  )
}
