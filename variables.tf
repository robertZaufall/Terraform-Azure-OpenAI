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
variable "default_region" {
  type        = string
  default     = "East US 2"
  description = "Default location, can be overridden by models' region"
}

variable "models" {
  type = list(object({
    name     = string
    model    = string
    format   = optional(string, "OpenAI")
    version  = optional(string, "1")
    sku_name = optional(string, "GlobalStandard")
    capacity = string
    region   = optional(string, "East US 2")
  }))

  description = "Array of app metadata objects"
}
