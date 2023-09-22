variable "subscription_id"{
  type=string
}
variable "client_id"{
  type=string
  
}
variable "client_secret"{
  type=string
  
}
variable "tenant_id"{
  type=string
  
}
variable "prefix"{
  type=string
  default="azuretutorial"
}

variable "account_tier"{
  type=string
  default="Standard"
}

variable "env"{
  type=string
  default="dev"
}

variable "access_type"{
  type=string
  default="private"
}

variable "stroage_type"{
  type=string
  default="Block"
}

variable "storage_source"{
  type=string
  default="some-local-file.zip"
}

variable "kube_name"{
  type=string
  default="example_aks1"
}

variable "kube_dns"{
  type=string
  default="exampleaks1"
}

variable "pool_name"{
  type=string
  default="default"
}

variable "vm_size"{
  type=string
  default="Standard_D2_v2"
}

variable "kube_identity"{
  type=string
  default="SystemAssigned"
}

variable "kube_env"{
  type=string
  default="Production"
}

variable "node_count"{
  type=int
  default=1
}

variable "cert_sensitive"{
  type=bool
  default=true
}

variable "node_count"{
  type=int
  default=1
}

variable "cert_sensitive"{
  type=bool
  default=true
}

