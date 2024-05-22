# server
variable "name" {
  type        = string
  description = "The name of the Microsoft SQL Server. This needs to be globally unique within Azure. "

}
variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Microsoft SQL Server."

}
variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists.Central India or South India"

}
variable "server_version" {
  type        = string
  description = "The version for the new server. Valid values are: 2.0 (for v11 server) and 12.0 (for v12 server)."
  default     = "12.0"

}
variable "administrator_login" {
  type        = string
  description = "The administrator login name for the new server."

}
variable "connection_policy" {
  type        = string
  description = "The connection policy the server will use. Possible values are Default, Proxy, and Redirect. Defaults to Default."
  default     = "Default"

}
variable "public_network_access_enabled" {
    type = bool
    description = "Whether public network access is allowed for this server. Defaults to true."
    default = true

}

variable "keyvault_name" {
  type = string
  
}