<!-- BEGIN_TF_DOCS -->
# `terraform-local-parameter` #

#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application"></a> [application](#input_application) | ID Element - The Component or Solution's Name | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input_namespace) | ID Element - A Global-Level Identifier. Company Name, Contracting Firm, or Business-Unit - perhaps Cloud-service are Appropriate | `string` | n/a | yes |
| <a name="input_service"></a> [service](#input_service) | ID Element - Service(s) either Consumed or Provided i.e. "EC2", "Custom-Microservice-Name", "K8s" | `string` | n/a | yes |
| <a name="input_casings"></a> [casings](#input_casings) | n/a | `map(string)` | <pre>{<br>  "application": "title",<br>  "environment": "title",<br>  "identifier": "title",<br>  "name": "none",<br>  "namespace": "title",<br>  "service": "title",<br>  "tf": "title"<br>}</pre> | no |
| <a name="input_environment"></a> [environment](#input_environment) | ID Element - "Development" \| "QA" \| "Staging" \| "UAT" \| "Pre-Production" \| "Production" | `string` | `"Development"` | no |
| <a name="input_identifier"></a> [identifier](#input_identifier) | ID Element - An Optional Identifier to Further Define the Resource | `string` | `null` | no |
| <a name="input_key-casing"></a> [key-casing](#input_key-casing) | n/a | `string` | `"none"` | no |
| <a name="input_name-overwrite"></a> [name-overwrite](#input_name-overwrite) | A Name Tag Escape Hatch - Useful for Larger, Single Resource Terraform Module(s) | `string` | `null` | no |
| <a name="input_prefix-separator"></a> [prefix-separator](#input_prefix-separator) | Prefix the Separator to the Start of the ID String | `bool` | `false` | no |
| <a name="input_separator"></a> [separator](#input_separator) | The ID's Element Separator | `string` | `"-"` | no |
| <a name="input_suffix-separator"></a> [suffix-separator](#input_suffix-separator) | Suffix the Separator to the End of the ID String | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input_tags) | Additional Tags (e.g. `{'Business-Unit': 'XYZ'}`); Will Overwrite Other Keys Depending on Other Inputs + Tag Keys | `map(string)` | `{}` | no |
| <a name="input_tf"></a> [tf](#input_tf) | Non-ID Element - Tag Setter | `string` | `"True"` | no |
| <a name="input_value-casing"></a> [value-casing](#input_value-casing) | n/a | `string` | `"none"` | no |

#### Outputs ####

```bash
terraform output --json > output.json
```

Results in the following:

```json
{
    "application": {
        "sensitive": false,
        "type": "string",
        "value": "Application"
    },
    "environment": {
        "sensitive": false,
        "type": "string",
        "value": "Development"
    },
    "input": {
        "sensitive": false,
        "type": [
            "object",
            {
                "application": "string",
                "casings": [
                    "map",
                    "string"
                ],
                "environment": "string",
                "namespace": "string",
                "prefix-delimiter": "bool",
                "separator": "string",
                "service": "string",
                "tags": [
                    "map",
                    "string"
                ],
                "tf": "string"
            }
        ],
        "value": {
            "application": "Application",
            "casings": {
                "application": "title",
                "environment": "title",
                "identifier": "title",
                "name": "none",
                "namespace": "title",
                "service": "title",
                "tf": "title"
            },
            "environment": "Development",
            "namespace": "Namespace",
            "prefix-delimiter": false,
            "separator": "-",
            "service": "Service",
            "tags": {},
            "tf": "True"
        }
    },
    "name": {
        "sensitive": false,
        "type": "string",
        "value": "Namespace-Development-Application-Service"
    },
    "namespace": {
        "sensitive": false,
        "type": "string",
        "value": "Namespace"
    },
    "service": {
        "sensitive": false,
        "type": "string",
        "value": "Service"
    },
    "tags": {
        "sensitive": false,
        "type": [
            "object",
            {
                "Application": "string",
                "Environment": "string",
                "Name": "string",
                "Namespace": "string",
                "Service": "string",
                "TF": "string"
            }
        ],
        "value": {
            "Application": "Application",
            "Environment": "Development",
            "Name": "Namespace-Development-Application-Service",
            "Namespace": "Namespace",
            "Service": "Service",
            "TF": "True"
        }
    }
}
```

---

## Documentation ##

Documentation is both programmatically and conventionally generated.

**Note** - Given the workflow between `git` & `pre-commit`, when creating
a new commit, ensure to run the following:

```bash
git commit -a --message "..."
```

If a commit shows as a **Failure**, ***such is the job of the pre-commit hook***. 
Simply re-commit and then the repository should be able to be pushed to.

### Generating `tfvars` & `tfvars.json` ###

```bash
terraform-docs tfvars hcl "$(git rev-parse --show-toplevel)"

terraform-docs tfvars json "$(git rev-parse --show-toplevel)"
```

### `terraform-docs` ###

In order to install `terraform-docs`, ensure `brew` is installed (for MacOS systems), and run

```bash
brew install terraform-docs
```

If looking to upgrade:

```bash
brew uninstall terraform-docs
brew install terraform-docs
```

It's elected to use `brew uninstall` vs `brew upgrade` because old versions are then removed.

### `git` & `pre-commit` ###

Documentation is often a second thought; refer to the following steps to ensure documentation is always updated
upon `git commit`.

1. Install Pre-Commit
    ```bash
    brew install pre-commit || pip install pre-commit
    ```
2. Check Installation + Version
    ```bash
    pre-commit --version
    ```
3. Generate Configuration (`.pre-commit-config.yaml`)
4. Configure `git` hooks
    ```bash
    pre-commit install
    pre-commit install-hooks
    ```
    - If any errors show:
        ```bash
        git config --unset-all core.hooksPath
        ```

**Most Importantly**

> *`pre-commit install` should always be the first command after a project is cloned.*
<!-- END_TF_DOCS -->