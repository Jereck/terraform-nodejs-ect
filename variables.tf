variable "ami_id" {
  description = "ami-0e449927258d45bc4"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "key_name" {
  description = "aws-pc-keypair"
  type        = string
}
