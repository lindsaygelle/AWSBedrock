locals {
  organization = (var.organization != null ? var.organization : lower(random_pet.organization.id))
}
