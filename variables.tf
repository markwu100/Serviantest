variable "user_name" { default = "ubuntu" }
variable "ssh_key_path" { 
  default = "../../postgre.pem" 
  }

variable "ssh_key_name" { 
  default = "postgre" 
  }
  
variable "cidr" { 
  default  ="10.2.2.0/23"
}

variable "source_cidr_block" { 
  default  = "10.2.2.0/25"
}

variable "source_cidr_block1" { 
  default  = "10.2.3.0/25"
}

variable "private_cidr_block" {
  default = "10.2.2.128/25"
}

variable "private_cidr_block1" {
  default = "10.2.3.128/25"
}

variable "region" { 
   default = "ap-southeast-2" 
}

 variable "private_key_path" {
   default     = "postgre.pem"
 }

  variable "asg_max" {
   default     = "4"
 }

   variable "asg_min" {
   default     = "2"
 }

   variable "asg_desired" {
   default     = "4"
 }

  variable "access_key" {
   
 }

  variable "secret_access_key" {
   
 }

variable "db_password" {
  default = "changeme"
}
