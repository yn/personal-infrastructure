variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "us-east-1"
}
provider "aws" {
  allowed_account_ids = ["883753636031"]
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "us-east-1"
}
