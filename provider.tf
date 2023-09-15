terraform {
  required_providers{
    azurerm={
      source="hashicorp/terrafrom/azurerm"
      version=">3.70.0"
    }
  }
  required_version=">1.4.0"
}

provider "azurerm"{
  features{}
  skip_provider_registration="true"
  
}
