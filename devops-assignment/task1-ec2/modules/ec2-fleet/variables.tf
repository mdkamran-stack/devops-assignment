variable "instances" {
  type = map(object({
    instance_type = string
    volume_type   = string
    volume_size   = number
    iops          = optional(number)
    key_name      = string
    environment   = string
    owner         = string
  }))
  validation {
    condition     = length(var.instances) == 5
    error_message = "Exactly five instances must be configured."
  }
}
