terraform {
  backend "s3" {
    bucket = "s3-remote-backend-2024"
    key = "github-actions/terraform.tfstate"
    region = "us-west-2"    
  }
}

provider "aws" {  
    region = "us-west-2"
}

resource "aws_vpc" "actions2" {
    cidr_block = "10.0.0.0/24"

    tags = {
        Name = "GitHub-Actions" 
  }
} 