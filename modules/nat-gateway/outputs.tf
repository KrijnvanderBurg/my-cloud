# -----------------------------------------------------------------------------
# NAT Gateway Module - Outputs
# -----------------------------------------------------------------------------

output "id" {
  description = "The ID of the NAT gateway"
  value       = azurerm_nat_gateway.this.id
}

output "name" {
  description = "The name of the NAT gateway"
  value       = azurerm_nat_gateway.this.name
}

output "public_ip_address" {
  description = "The public IP address of the NAT gateway"
  value       = azurerm_public_ip.this.ip_address
}
