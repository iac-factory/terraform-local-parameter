locals {
    name-normalize = (var.identifier != null) ? join(var.separator, [
        (var.value-casing.namespace == "title") ? title(var.namespace) : (var.value-casing.namespace == "lower") ? lower(var.namespace) : (var.value-casing.namespace == "upper") ? upper(var.namespace) : var.namespace,
        (var.value-casing.environment == "title") ? title(var.environment) : (var.value-casing.environment == "lower") ? lower(var.environment) : (var.value-casing.environment == "upper") ? upper(var.environment) : var.environment,
        (var.value-casing.application == "title") ? title(var.application) : (var.value-casing.application == "lower") ? lower(var.application) : (var.value-casing.application == "upper") ? upper(var.application) : var.application,
        (var.value-casing.service == "title") ? title(var.service) : (var.value-casing.service == "lower") ? lower(var.service) : (var.value-casing.service == "upper") ? upper(var.service) : var.service,
        (var.value-casing.identifier == "title") ? title(var.identifier) : (var.value-casing.identifier == "lower") ? lower(var.identifier) : (var.value-casing.identifier == "upper") ? upper(var.identifier) : var.identifier,
    ]) : join(var.separator, [
        (var.value-casing.namespace == "title") ? title(var.namespace) : (var.value-casing.namespace == "lower") ? lower(var.namespace) : (var.value-casing.namespace == "upper") ? upper(var.namespace) : var.value-casing.namespace,
        (var.value-casing.environment == "title") ? title(var.environment) : (var.value-casing.environment == "lower") ? lower(var.environment) : (var.value-casing.environment == "upper") ? upper(var.environment) : var.value-casing.environment,
        (var.value-casing.application == "title") ? title(var.application) : (var.value-casing.application == "lower") ? lower(var.application) : (var.value-casing.application == "upper") ? upper(var.application) : var.value-casing.application,
        (var.value-casing.service == "title") ? title(var.service) : (var.value-casing.service == "lower") ? lower(var.service) : (var.value-casing.service == "upper") ? upper(var.service) : var.value-casing.service,
    ])

    name-separation = (var.prefix-separator == true) ? join(var.separator, ["", local.name-normalize]) : local.name-normalize
    name-separation-ending = (var.suffix-separator == true) ? join(var.separator, [local.name-separation, ""]) : local.name-separation

    name-casing = (var.casing == "title") ? title(local.name-separation-ending) : (var.casing == "lower") ? lower(local.name-separation-ending) : (var.casing == "upper") ? upper(local.name-separation-ending) : local.name-separation-ending

    name = (var.name-overwrite == null) ? try(var.value-casing.name == "title", false) ? title(local.name-casing) : try(var.value-casing.name == "lower", false) ? lower(local.name-casing) : try(var.value-casing.name == "upper", false) ? upper(local.name-casing) : local.name-casing : var.name-overwrite

    /*** The Mapping between Title-Casing-Casts to their Associated User-Defined Input(s) (Variables) */
    tags-normalize = merge({
        TF          = try(var.value-casing.tf == "title", false) ? title(var.tf) : try(var.value-casing.tf == "lower", false) ? lower(var.tf) : try(var.value-casing.tf == "upper", false) ? upper(var.tf) : var.tf
        Namespace   = (var.value-casing.namespace == "title") ? title(var.namespace) : (var.value-casing.namespace == "lower") ? lower(var.namespace) : (var.value-casing.namespace == "upper") ? upper(var.namespace) : var.namespace
        Environment = (var.value-casing.environment == "title") ? title(var.environment) : (var.value-casing.environment == "lower") ? lower(var.environment) : (var.value-casing.environment == "upper") ? upper(var.environment) : var.environment
        Service     = (var.value-casing.service == "title") ? title(var.service) : (var.value-casing.service == "lower") ? lower(var.service) : (var.value-casing.service == "upper") ? upper(var.service) : var.service
        Application = (var.value-casing.application == "title") ? title(var.application) : (var.value-casing.application == "lower") ? lower(var.application) : (var.value-casing.application == "upper") ? upper(var.application) : var.application
        Identifier = (var.identifier != null) ? (var.value-casing.identifier == "title") ? title(var.identifier) : (var.value-casing.identifier == "lower") ? lower(var.identifier) : (var.value-casing.identifier == "upper") ? upper(var.identifier) : var.identifier : null
        Name = try(var.value-casing.name == "title", false) ? title(local.name) : try(var.value-casing.name == "lower", false) ? lower(local.name) : try(var.value-casing.name == "upper", false) ? upper(local.name) : local.name
    }, var.tags)

    /*** The Mapping between Casing-Casts of Keys */
    tags-key-mapping = (var.casing == "title") ? { for key in keys(local.tags-normalize) : title(key) => local.tags-normalize[ key ] } : (var.key-casing == "lower") ? { for key in keys(local.tags-normalize) : lower(key) => local.tags-normalize[ key ] } : (var.key-casing == "upper") ? { for key in keys(local.tags-normalize) : upper(key) => local.tags-normalize[ key ] } : { for key in keys(local.tags-normalize) : key => local.tags-normalize[ key ] }
    /*** The Mapping between Casing-Casts of Keys + Values */
    tags-value-mapping = (var.casing == "title") ? { for key in keys(local.tags-key-mapping) : key => title(local.tags-key-mapping[ key ]) } : (var.value-casing == "lower") ? { for key in keys(local.tags-key-mapping) : key => lower(local.tags-key-mapping[ key ]) } : (var.value-casing == "upper") ? { for key in keys(local.tags-key-mapping) : key => upper(local.tags-key-mapping[ key ]) } : { for key in keys(local.tags-key-mapping) : key => local.tags-key-mapping[ key ] }

    /*** The Mapping between Casing-Casts of Keys + Values, & User-Defined `tags`, Cleansed of Key-Value Pairs containing NIL */
    tags = (var.value-casing == "title") ? { for key in keys(local.tags-value-mapping) : key => title(local.tags-value-mapping[ key ]) if local.tags-value-mapping[ key ] != null } : (var.value-casing == "lower") ? { for key in keys(local.tags-value-mapping) : key => lower(local.tags-value-mapping[ key ]) if local.tags-value-mapping[ key ] != null } : (var.value-casing == "upper") ? { for key in keys(local.tags-value-mapping) : key => upper(local.tags-value-mapping[ key ]) if local.tags-value-mapping[ key ] != null } : { for key in keys(local.tags-value-mapping) : key => local.tags-value-mapping[ key ] if local.tags-value-mapping[ key ] != null }

    namespace-normalize = (var.key-casing.namespace == "title") ? local.tags["Namespace"] : (var.key-casing.namespace == "lower") ? local.tags["namespace"] : (var.key-casing.namespace == "upper") ? local.tags["NAMESPACE"] : local.tags["Namespace"]
    environment-normalize = (var.key-casing.environment == "title") ? local.tags["Environment"] : (var.key-casing.environment == "lower") ? local.tags["environment"] : (var.key-casing.environment == "upper") ? local.tags["ENVIRONMENT"] : local.tags["Environment"]
    service-normalize = (var.key-casing.service == "title") ? local.tags["Service"] : (var.key-casing.service == "lower") ? local.tags["service"] : (var.key-casing.service == "upper") ? local.tags["SERVICE"] : local.tags["Service"]
    application-normalize = (var.key-casing.application == "title") ? local.tags["Application"] : (var.key-casing.application == "lower") ? local.tags["application"] : (var.key-casing.application == "upper") ? local.tags["APPLICATION"] : local.tags["Application"]
    identifier-normalize = (var.identifier != null) ? (var.key-casing.identifier == "title") ? local.tags["Identifier"] : (var.key-casing.identifier == "lower") ? local.tags["identifier"] : (var.key-casing.identifier == "upper") ? local.tags["IDENTIFIER"] : local.tags["Identifier"] : null

    namespace = (var.value-casing.namespace == "title") ? title(local.namespace-normalize) : (var.value-casing.namespace == "lower") ? lower(local.namespace-normalize) : (var.value-casing.namespace == "upper") ? upper(local.namespace-normalize) : local.namespace-normalize
    environment = (var.value-casing.environment == "title") ? title(local.environment-normalize) : (var.value-casing.environment == "lower") ? lower(local.environment-normalize) : (var.value-casing.environment == "upper") ? upper(local.environment-normalize) : local.environment-normalize
    service = (var.value-casing.service == "title") ? title(local.service-normalize) : (var.value-casing.service == "lower") ? lower(local.service-normalize) : (var.value-casing.service == "upper") ? upper(local.service-normalize) : local.service-normalize
    application = (var.value-casing.application == "title") ? title(local.application-normalize) : (var.value-casing.application == "lower") ? lower(local.application-normalize) : (var.value-casing.application == "upper") ? upper(local.application-normalize) : local.application-normalize
    identifier = (var.identifier != null) ? (var.value-casing.identifier == "title") ? title(local.identifier-normalize) : (var.value-casing.identifier == "lower") ? lower(local.identifier-normalize) : (var.value-casing.identifier == "upper") ? upper(local.identifier-normalize) : local.identifier-normalize : null
}