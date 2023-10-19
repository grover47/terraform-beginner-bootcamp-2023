
terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "5.16.2"
    }
  }
}

terraform {
  cloud {
    organization = "terraform_beginner_bootcamp"

    workspaces {
      name = "terra-house-1"
    }
  }
}


provider "aws" {

}

provider "random" {
 
}
