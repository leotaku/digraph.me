packer {
  required_version = "~> 1.7"
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
}
