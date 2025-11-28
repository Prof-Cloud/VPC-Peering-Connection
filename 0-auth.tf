terraform {
  required_version = ">=1.12"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.22.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"


  default_tags {
    tags = {
      TeamMember  = "Prof Cloud"
      ManagedBy   = "Terraform"
      Environment = "Dev"
      Location    = "London"
    }
  }
}

#Dubai Provider (alias)
provider "aws" {
  alias  = "Dubai"
  region = "me-central-1"


  default_tags {
    tags = {
      TeamMember  = "Prof Cloud"
      ManagedBy   = "Terraform"
      Environment = "Dev"
      Location    = "Dubai"
    }
  }
}