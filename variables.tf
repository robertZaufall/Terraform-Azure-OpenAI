variable "build_number" {
  type        = string
  default     = "1.0"
  description = "Build number"
}
variable "release_number" {
  type        = string
  default     = "1"
  description = "Release number"
}
variable "cga_name" {
  type        = string
  default     = "x4utestai"
  description = "Cognitive account name or prefix"
}

variable "models" {
  type = list(object({
    name     = string
    model    = string
    format   = string
    version  = string
    capacity = string
    region   = string
  }))

  description = "Array of app metadata objects"
}
