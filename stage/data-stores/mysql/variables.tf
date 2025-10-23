variable "mysqluser" {
  description = "The database admin user"
  type = string 
  sensitive = true 
}

variable "mysqlpasswd" {
  description = "The database admin password"
  type = string
  sensitive = true
}
