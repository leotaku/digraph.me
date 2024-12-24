provider "hcloud" {}

resource "hcloud_ssh_key" "default" {
  name       = "default"
  public_key = file("./secrets/id_rsa.pub")
}

data "hcloud_image" "webserver" {
  with_selector     = "is_custom==true"
  with_architecture = "arm"
  most_recent       = true
}

resource "hcloud_firewall" "web_and_ssh" {
  name = "web_and_ssh"
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "443"
    source_ips = ["0.0.0.0/0", "::/0"]
  }
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "80"
    source_ips = ["0.0.0.0/0", "::/0"]
  }
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "22"
    source_ips = ["0.0.0.0/0", "::/0"]
  }
}

resource "hcloud_server" "webserver" {
  name         = "webserver"
  server_type  = "cax11"
  ssh_keys     = [resource.hcloud_ssh_key.default.id]
  firewall_ids = [hcloud_firewall.web_and_ssh.id]
  image        = data.hcloud_image.webserver.id
}
