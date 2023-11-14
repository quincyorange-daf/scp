#Terraform Backend
terraform {
  backend "s3" {
    bucket         = "itptestterrafombackend"
    dynamodb_table = "ITPTestTFState"
    key            = "tfstate/itp-test.tfstate"
    region         = "ap-southeast-2"
    encrypt        = "true"
  }
}
