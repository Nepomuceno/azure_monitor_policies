data "template_file" "is_linux" {
  template = "${file("${path.module}/templates/is_linux.tpl")}"
}

data "template_file" "protected_settings" {
  template = "${file("${path.module}/templates/private_config.tpl")}"

  vars {
    storagename     = "${var.storage_name}"
    storagesasToken = "${var.storage_sas_key}"
    eh_sas_url      = "${var.eh_sas_url}"
  }
}

data "template_file" "postresource" {
  template = "${file("${path.module}/templates/post_resource.tpl")}"

  vars {
    sinks = "logJsonBlob,eventHubsLogs"
  }
}

data "template_file" "preresource" {
  template = "${file("${path.module}/templates/pre_resource.tpl")}"

  vars {
    storagename = "${var.storage_name}"
  }
}

data "template_file" "template_deployment_linux" {
  template = "${file("${path.module}/templates/la_linux_deployment.tpl")}"

  vars {
    version            = "3.0"
    preresource        = "${data.template_file.preresource.rendered}"
    postresource       = "${data.template_file.postresource.rendered}"
    protected_settings = "${data.template_file.protected_settings.rendered}"
  }
}

data "template_file" "existence_condition_linux" {
  template = "${file("${path.module}/templates/existence_condition_linux_la.tpl")}"
}

data "template_file" "la_parameters" {
  template = "${file("${path.module}/templates/la_parameters.tpl")}"
}

data "template_file" "policy_effect" {
  template = "${file("${path.module}/templates/policy_effect.tpl")}"

  vars {
    deploy_name           = "\"deployed by policy\""
    role_definition       = "\"/providers/microsoft.authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c\""
    deployment_template   = "${data.template_file.template_deployment_linux.rendered}"
    existence_condition   = "${data.template_file.existence_condition_linux.rendered}"
    deployment_parameters = "${data.template_file.la_parameters.rendered}"
  }
}

data "template_file" "base_policy" {
  template = "${file("${path.module}/templates/base_policy.tpl")}"

  vars {
    os_definition = "${data.template_file.is_linux.rendered}"
    effect        = "${data.template_file.policy_effect.rendered}"
  }
}

locals {
  base_policy = "${data.template_file.base_policy.rendered}"
}
