resource "yandex_vpc_network" "network" {
  name = "network"
}

resource "yandex_vpc_subnet" "subnet-a" {
  name           = "subnet-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.1.0/24"]
}

resource "yandex_vpc_subnet" "subnet-b" {
  name           = "subnet-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.3.0/24"]
}

resource "yandex_vpc_subnet" "public" {
  name           = "public"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.5.0/24"]
}
#
#resource "yandex_vpc_security_group" "sec-group" {
#  name        = "security-group"
#  description = ""
#  network_id  = yandex_vpc_network.network.id
#
#  ingress {
#    protocol = "TCP"
#    description = "Kibana"
#    v4_cidr_blocks = ["${yandex_compute_instance.kibana.network_interface.0.nat_ip_address}/32"]
#    port = 5601
#  }
#
#  ingress {
#    protocol = "TCP"
#    description = "Grafana"
#    v4_cidr_blocks = ["${yandex_compute_instance.grafana.network_interface.0.nat_ip_address}/32"]
#    port = 3000
#  }
#
#  ingress {
#    protocol = "TCP"
#    description = "Bastion"
#    v4_cidr_blocks = ["${yandex_compute_instance.bastion.network_interface.0.nat_ip_address}/32"]
#    port = 22
#  }
#
#  ingress {
#    protocol = "TCP"
#    description = "Load Balancer"
#    v4_cidr_blocks = ["84.252.130.22/32"]
#    port = 80
#  }
#
#  egress {
#    protocol = "ANY"
#    description = "Egress"
#    v4_cidr_blocks = ["192.168.0.0/16"]
#  }
##  egress {
##    protocol = "TCP"
##    description = "Bastion SSH"
##    v4_cidr_blocks = [yandex_compute_instance.bastion
##  }
##  ingress {
##    protocol       = "TCP"
##    description    = "Rule description 1"
##    v4_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
##    port           = 8080
##  }
##
##  egress {
##    protocol       = "ANY"
##    description    = "Rule description 2"
##    v4_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
##    from_port      = 8090
##    to_port        = 8099
##  }
#}