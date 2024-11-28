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
  image           = "debian-12"
  ssh_username    = "root"
  snapshot_labels = { is_custom : true }
}

build {
  sources = ["source.hcloud.debian"]

  provisioner "file" {
    source      = "cosmopolitan/o/asan/tool/net/redbean"
    destination = "/usr/local/bin/"
  }

  provisioner "file" {
    sources     = ["redbean.service", "certbot.service.d"]
    destination = "/etc/systemd/system/"
  }

  provisioner "shell" {
    script = "setup.sh"
  }

  provisioner "file" {
    source      = "static/"
    destination = "/var/web/"
  }

}
