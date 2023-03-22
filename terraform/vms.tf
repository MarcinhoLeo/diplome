resource "yandex_compute_instance" "vm1" {
  name = "vm1"
  boot_disk {
    initialize_params {
      image_id = "fd83klic6c8gfgi40urb"
      size = 10
    }
  }
  zone = "ru-central1-a"
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-a.id
    nat       = false
  }
  resources {
    cores  = 2
    memory = 2
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "vm2" {
  name = "vm2"
  boot_disk {
    initialize_params {
      image_id = "fd83klic6c8gfgi40urb"
      size = 10
    }
  }
  zone = "ru-central1-b"
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-b.id
    nat       = false
  }
  resources {
    cores  = 2
    memory = 2
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "prometheus" {
  name = "prometheus"
  boot_disk {
    initialize_params {
      image_id = "fd83klic6c8gfgi40urb"
      size = 10
    }
  }
  zone = "ru-central1-b"
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-b.id
    nat       = false
  }
  resources {
    cores  = 2
    memory = 2
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "grafana" {
  name = "grafana"
  boot_disk {
    initialize_params {
      image_id = "fd83klic6c8gfgi40urb"
      size = 10
    }
  }
  zone = "ru-central1-b"
  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    nat       = true
  }
  resources {
    cores  = 2
    memory = 2
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "elastic" {
  name = "elastic"
  boot_disk {
    initialize_params {
      image_id = "fd83klic6c8gfgi40urb"
      size = 10
    }
  }
  zone = "ru-central1-b"
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-b.id
    nat       = false
  }
  resources {
    cores  = 2
    memory = 2
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "kibana" {
  name = "kibana"
  boot_disk {
    initialize_params {
      image_id = "fd83klic6c8gfgi40urb"
      size = 10
    }
  }
  zone = "ru-central1-b"
  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    nat       = true
  }
  resources {
    cores  = 2
    memory = 2
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "bastion" {
  name = "bastion"
  boot_disk {
    initialize_params {
      image_id = "fd83klic6c8gfgi40urb"
      size = 10
    }
  }
  zone = "ru-central1-b"
  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    nat       = true
  }
  resources {
    cores  = 2
    memory = 2
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}