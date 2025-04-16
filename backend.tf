terraform {
  backend "s3" {
    bucket         = "my-modulebucket"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
