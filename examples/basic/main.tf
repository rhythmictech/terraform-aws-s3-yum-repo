
module "example" {
  source = "../.."

  tags = {
    name = "test"
  }
}

output "example" {
  value = module.example
}
