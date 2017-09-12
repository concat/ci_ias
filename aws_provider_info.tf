provider "aws" {
  alias = "primary"
  region = "us-east-1"
  version = "~> 0.1"
}

provider "aws" {
  alias = "secondary"
  region = "us-east-2"
  version = "~> 0.1"
}
