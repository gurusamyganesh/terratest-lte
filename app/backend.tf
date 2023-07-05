
# terraform {
#   backend "s3" {
#     bucket    = "ganeshaws-terraformstate"
#     key       = "webapp-ecs.tfstate"
#     region    = "us-east-2"
#     profile   = "terraform-user"
#   }
# }

terraform {
  backend "local" {
    path = ".terraformstate"
  }
}