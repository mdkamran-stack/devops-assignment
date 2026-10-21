variable "aws_region" {
   type = string
  default = "us-west-2"
   }
variable "state_bucket_name" 
{ 
  type = string

  description = "my_state0001"
   }
variable "lock_table_name" 
{ 
  type = string

  default = "terraform-state-locks"
   }
