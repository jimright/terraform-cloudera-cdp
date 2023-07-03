terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.67.0"
    }
    cdp = {
      source  = "cloudera-labs/cdp"
      version = "0.1.0-rc3"
    }

    http = {
      source  = "hashicorp/http"
      version = "3.2.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }

  required_version = "> 1.3.0"
}
