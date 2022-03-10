terraform {
  backend "s3" {
    bucket         = "hashicorp-terraform-backend"
    key            = "jakoberpf/artemis-bootstrap/live/terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    kms_key_id     = "f066dc61-8dbe-4bbb-b4fe-1171fa476a4c"
    dynamodb_table = "tf-remote-state-lock"
  }
  required_providers {
    zerotier = {
      source = "zerotier/zerotier"
      version = "1.2.0"
    }
  }
}

provider "zerotier" {
  zerotier_central_token = var.zerotier_central_token
}
