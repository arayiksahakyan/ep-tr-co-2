resource "kubectl_manifest" "secret_provider" {
  yaml_body = templatefile(var.secret_provider_template_path, {
    aks_kv_access_identity_id  = var.aks_kv_access_identity_id
    kv_name                    = var.kv_name
    redis_password_secret_name = var.redis_password_secret_name
    redis_url_secret_name      = var.redis_url_secret_name
    tenant_id                  = var.tenant_id
  })
}

resource "kubectl_manifest" "deployment" {
  yaml_body = templatefile(var.deployment_template_path, {
    acr_login_server = var.acr_login_server
    app_image_name   = var.app_image_name
    image_tag        = var.image_tag
  })

  wait_for_rollout = true

  depends_on = [kubectl_manifest.secret_provider]
}

resource "kubectl_manifest" "service" {
  yaml_body = file(var.service_manifest_path)

  wait_for {
    field {
      key        = "status.loadBalancer.ingress.[0].ip"
      value      = "^(\\d+(\\.|$)){4}"
      value_type = "regex"
    }
  }

  depends_on = [kubectl_manifest.deployment]
}

data "kubernetes_service_v1" "app" {
  metadata {
    name      = var.service_name
    namespace = var.namespace
  }

  depends_on = [kubectl_manifest.service]
}
