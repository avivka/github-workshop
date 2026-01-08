terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "github" {}

resource "github_repository" "new_repo" {
  name        = var.repo_name
  description = "Created via Terraform and GitHub Actions Workshop"
  visibility  = "private"

  template {
    owner      = var.template_owner
    repository = var.template_repo
  }
}
