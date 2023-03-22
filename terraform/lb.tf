resource "yandex_alb_target_group" "target_group" {
  name = "nginx-target-group"

  target {
    subnet_id = yandex_vpc_subnet.subnet-a.id
    ip_address   = yandex_compute_instance.vm1.network_interface.0.ip_address
  }

  target {
    subnet_id = yandex_vpc_subnet.subnet-b.id
    ip_address   = yandex_compute_instance.vm2.network_interface.0.ip_address
  }
}

resource "yandex_alb_backend_group" "backend-group" {
  name                     = "nginx-backend-group"

  http_backend {
    name                   = "nginx"
    weight                 = 1
    port                   = 80
    target_group_ids       = [yandex_alb_target_group.target_group.id]
    load_balancing_config {
      panic_threshold      = 90
    }
    healthcheck {
      timeout              = "10s"
      interval             = "2s"
      healthy_threshold    = 10
      unhealthy_threshold  = 15
      http_healthcheck {
        path               = "/"
      }
    }
  }
}

resource "yandex_alb_http_router" "nginx-router" {
  name   = "nginx-http-router"
  labels = {
    target = "nginx"
  }
}

resource "yandex_alb_virtual_host" "vh" {
  name           = "nginx-virtual-host"
  http_router_id = yandex_alb_http_router.nginx-router.id
  route {
    name = "nginx-route"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.backend-group.id
        timeout          = "3s"
      }
    }
  }
}

resource "yandex_alb_load_balancer" "nginx-lb" {
  name        = "nginx-load-balancer"
  network_id  = yandex_vpc_network.network.id

  allocation_policy {
    location {
      zone_id   = "ru-central1-b"
      subnet_id = yandex_vpc_subnet.public.id
    }
  }

  listener {
    name = "nginx"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [ 80 ]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.nginx-router.id
      }
    }
  }
}

data "yandex_alb_load_balancer" "alb-data" {
  load_balancer_id = yandex_alb_load_balancer.nginx-lb.id
}

output "alb_data" {
  value = data.yandex_alb_load_balancer.alb-data
}