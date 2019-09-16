terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "selfhost"

    workspaces {
      name = "tfbook"
    }
  }
}
