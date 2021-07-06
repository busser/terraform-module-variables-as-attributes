# Using a resource as an object: works!

resource "random_pet" "my_pet" {
    length = 1
}

module "foo" {
    source = "./modules/uses-pet"
    pet    = random_pet.my_pet
}


# Using a module as an object: doesn't work...

module "mock_pet" {
    source = "./modules/mock-pet"
    length = 1
}

module "bar" {
    source = "./modules/uses-pet"
    pet    = module.mock_pet
}


# Using an intermediate local variable: doesn't work...

locals {
    intermediate_pet = {
        length = module.mock_pet.length
        id     = module.mock_pet.id
    }
}

module "baz" {
    source = "./modules/uses-pet"
    pet    = local.intermediate_pet
}
