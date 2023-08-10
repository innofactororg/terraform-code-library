variable "github_membership" {
  type = map(object({
    username = string
    role     = string
  }))
  description = "A map of GitHub usernames to their organization membership details."

  validation {
    # Ensure that each map key is a valid GitHub username.
    condition     = alltrue([for k, v in var.github_membership : can(regex("^[a-zA-Z0-9-]+$", k))])
    error_message = "All keys in github_membership must be valid GitHub usernames (alphanumeric characters and hyphens only)."
  }

  validation {
    # Ensure that each map value has a valid username and role.
    condition     = alltrue([for k, v in var.github_membership : can(v.username) && can(v.role) && contains(["member", "admin"], v.role)])
    error_message = "All values in github_membership must have a 'username' and 'role' key, and the 'role' value must be 'member' or 'admin'."
  }
}


variable "github_teams" {
  type = map(object({
    name                   = string
    description            = optional(string)
    privacy                = optional(string)
    parent_team_key        = optional(string)
    ldap_dn                = optional(string)
    create_default_maintainer = optional(bool)
  }))
  description = "A map of GitHub team names to their details."

}


variable "github_repositories" {
  type = map(object({
    name                   = string
    description            = string
    visibility             = string
    has_issues             = optional(bool)
    has_discussions        = optional(bool)
    has_projects           = optional(bool)
    has_wiki               = optional(bool)
    is_template            = optional(bool)
    allow_merge_commit     = optional(bool)
    allow_squash_merge     = optional(bool)
    allow_rebase_merge     = optional(bool)
    delete_branch_on_merge = optional(bool)
    has_downloads          = optional(bool)
    auto_init              = optional(bool)
    archived               = optional(bool)
    topics                 = optional(list(string))
  }))
  description = "A map of GitHub repository names to their details."

}


variable "github" {
  type = object({
    github_teams        = optional(map(object({
      name                   = string
      description            = optional(string)
      privacy                = optional(string)
      parent_team_key        = optional(string)
      ldap_dn                = optional(string)
      create_default_maintainer = optional(bool)
    })))
    github_repositories = optional(map(object({
      name                   = string
      description            = string
      visibility             = string
      has_issues             = optional(bool)
      has_discussions        = optional(bool)
      has_projects           = optional(bool)
      has_wiki               = optional(bool)
      is_template            = optional(bool)
      allow_merge_commit     = optional(bool)
      allow_squash_merge     = optional(bool)
      allow_rebase_merge     = optional(bool)
      delete_branch_on_merge = optional(bool)
      has_downloads          = optional(bool)
      auto_init              = optional(bool)
      archived               = optional(bool)
      topics                 = optional(list(string))
    })))
    github_membership   = optional(map(object({
      username = string
      role     = string
    })))
  })
  default = {}
}
