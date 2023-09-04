packer {
  required_plugins {
    hcloud = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/hcloud"
    }
  }
}

source "hcloud" "debian" {
  location        = "hel1"
  server_type     = "cx11"
  image           = "debian-11"
  ssh_username    = "root"
  snapshot_labels = { is_custom : true }
}

build {
  sources = ["source.hcloud.debian"]

  provisioner "shell" {
    script = "setup.sh"
  }

  provisioner "file" {
    source      = "Caddyfile"
    destination = "/etc/caddy/Caddyfile"
  }

  provisioner "file" {
    source      = "static/"
    destination = "/var/web"
  }
}
