variable "workload" {
  description = "The name of workload to deploy."
  default     = "clpdevsecops"
}

variable "environment" {
  description = "The name of the environment to deploy."
  default     = "test"
}

variable "location" {
  description = "The Azure region to deploy resources"
  default     = "eastus"
}