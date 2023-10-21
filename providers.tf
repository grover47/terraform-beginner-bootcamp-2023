
terraform {
  required_providers {
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
