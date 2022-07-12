variable "prefix-separator" {
    type = bool
    default = false
    description = "Prefix the Separator to the Start of the ID String"
}

variable "suffix-separator" {
    type = bool
    default = false
    description = "Suffix the Separator to the End of the ID String"
}

variable "tf" {
    type        = string
    description = "Non-ID Element - Tag Setter"
    default     = "True"
}

variable "name-overwrite" {
    type = string
    description = "A Name Tag Escape Hatch - Useful for Larger, Single Resource Terraform Module(s)"
    default = null
}

variable "namespace" {
    type        = string
    description = "ID Element - A Global-Level Identifier. Company Name, Contracting Firm, or Business-Unit - perhaps Cloud-service are Appropriate"
}

variable "environment" {
    type        = string
    default     = "Development"
    description = "ID Element - `Development`, `QA`, `Staging`, `UAT`, `Pre-Production`, `Production`"

    validation {
        condition     = var.environment != null
        error_message = "Environment != null"
    }
}

variable "service" {
    type        = string
    description = "ID Element - Service(s) either Consumed or Provided i.e. EC2, Custom-Microservice-Name, K8s"

    validation {
        condition     = var.service != null
        error_message = "Service != null"
    }
}

variable "application" {
    type        = string
    description = "ID Element - The Component or Solution's Name"

    validation {
        condition     = var.application != null
        error_message = "Application != null"
    }
}

variable "identifier" {
    type        = string
    description = "ID Element - An Optional Identifier to Further Define the Resource"
    default = null
}

variable "separator" {
    type        = string
    default     = "-"
    description = "The ID's Element Separator"

    validation {
        condition     = var.separator != null
        error_message = "Separator != null"
    }
}

variable "tags" {
    type        = map(string)
    default     = {}
    description = "Additional Tags (e.g. `{'Business-Unit': 'XYZ'}`); Will Overwrite Other Keys Depending on Other Inputs + Tag Keys"
}

variable "key-casing" {
    type = map(string)

    default = {
        tf = "upper"
        namespace = "title"
        environment = "title"
        service = "title"
        application = "title"
        identifier = "title"
        name = "none"
    }

    validation {
        condition = var.key-casing.application == null ? true : contains([
            "lower",
            "title",
            "upper",
            "none"
        ], var.key-casing.application)
        error_message = "[Application] Allowed values: `lower`, `title`, `upper`, `none`."
    }

    validation {
        condition = var.key-casing.environment == null ? true : contains([
            "lower",
            "title",
            "upper",
            "none"
        ], var.key-casing.environment)
        error_message = "[Environment] Allowed values: `lower`, `title`, `upper`, `none`."
    }

    validation {
        condition = var.key-casing.namespace == null ? true : contains([
            "lower",
            "title",
            "upper",
            "none"
        ], var.key-casing.namespace)
        error_message = "[Namespace] Allowed values: `lower`, `title`, `upper`, `none`."
    }

    validation {
        condition = var.key-casing.service == null ? true : contains([
            "lower",
            "title",
            "upper",
            "none"
        ], var.key-casing.service)
        error_message = "[Service] Allowed values: `lower`, `title`, `upper`, `none`."
    }
}

variable "value-casing" {
    type = map(string)

    default = {
        tf = "title"
        namespace = "title"
        environment = "title"
        service = "title"
        application = "title"
        identifier = "title"
        name = "none"
    }

    validation {
        condition = var.value-casing.application == null ? true : contains([
            "lower",
            "title",
            "upper",
            "none"
        ], var.value-casing.application)
        error_message = "[Application] Allowed values: `lower`, `title`, `upper`, `none`."
    }

    validation {
        condition = var.value-casing.environment == null ? true : contains([
            "lower",
            "title",
            "upper",
            "none"
        ], var.value-casing.environment)
        error_message = "[Environment] Allowed values: `lower`, `title`, `upper`, `none`."
    }

    validation {
        condition = var.value-casing.namespace == null ? true : contains([
            "lower",
            "title",
            "upper",
            "none"
        ], var.value-casing.namespace)
        error_message = "[Namespace] Allowed values: `lower`, `title`, `upper`, `none`."
    }

    validation {
        condition = var.value-casing.service == null ? true : contains([
            "lower",
            "title",
            "upper",
            "none"
        ], var.value-casing.service)
        error_message = "[Service] Allowed values: `lower`, `title`, `upper`, `none`."
    }
}

variable "casing" {
    type = string
    default = "none"
    description = "A Short-Circuit for the `Name` Tag Partial (Value) of the Parameter"

    validation {
        condition = var.casing == null ? true : contains([
            "lower",
            "title",
            "upper",
            "none"
        ], var.casing)
        error_message = "Allowed values: `lower`, `title`, `upper`, `none`."
    }
}