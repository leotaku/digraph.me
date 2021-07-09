packer {
  required_version = "~> 1.7"
}

source "hcloud" "ubuntu" {
  location        = "hel1"
  server_type     = "cx11"
  image           = "ubuntu-20.04"
  token           = var.hcloud_token
  ssh_username    = "root"
  snapshot_labels = { is_custom : true }
}

build {
  sources = ["source.hcloud.ubuntu"]

  provisioner "shell" {
    script = "setup.sh"
  }

  provisioner "file" {
    source      = "Caddyfile"
    destination = "/etc/caddy/Caddyfile"
  }
}
