terraform {
  required_version = "~> 1.10"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  cloud {
    organization = "taras-clp"

    # Below value is passed as an environment TF_WORKSPACE variable
    # workspaces {
    #  name = "test"
    # }
  }
}
