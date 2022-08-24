terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "skylark"

    workspaces {
      name = "sentinel-stage"
    }
  }
}


variable "tfe_hostname" {
  description = "The domain where your TFE is hosted."
  default     = "app.terraform.io"
}

variable "tfe_organization" {
  description = "The TFE organization to apply your changes to."
  default     = "example_corp"
}

variable "tfe_token" {
  description = "The TFE organization to apply your changes to."
  default     = "example_corp"
}

provider "tfe" {
  hostname = var.tfe_hostname
  token    = var.tfe_token
}

resource "tfe_policy_set" "d" {
  name          = "a"
  description   = "Policies that should be enforced on ALL infrastructure."
  organization  = "skylark"
  policies_path = "staging/"
  workspace_ids = ["ws-tGEWkng5AxjnKZTk","ws-jN3s8WtSqfyL2dad","ws-LZzs8vC5coGs1ho8"]
  vcs_repo {
    identifier         = "test1webapp/sentinel-stage"
    branch             = "main"
    ingress_submodules = false
    oauth_token_id     = ""
  }
}

resource "tfe_policy_set" "g" {
  name          = "b"
  description   = "Policies that should be enforced on ALL infrastructure."
  organization  = "pigeon"
  policies_path = "staging/"
  workspace_ids = ["ws-ARQa89snaZJRLQQi"]
  vcs_repo {
    identifier         = "test1webapp/sentinel-stage"
    branch             = "main"
    ingress_submodules = false
    oauth_token_id     = var.token_id
  }
}
