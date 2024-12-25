variable "ami" {
  description = "The AMI ID for the instance"
  default     = "ami-005fc0f236362e99f"
}
variable "instance_type" {
  description = "The instance type"
  default     = "t3.large"
}
variable "key_name" {
  description = "The key pair name"
  default     = "ivolve1"
}
variable "subnet_id" {
  description = "The ID of the subnet"
}
variable "security_group_id" {
  description = "The ID of the security group"
}