terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 2.0"
    }
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.0"
    }
  }
  backend "local" {
    path = "./.terraform.tfstate"
  }
}

resource "hcloud_ssh_key" "default" {
  name       = "default"
  public_key = file("./secrets/id_rsa.pub")
}

data "hcloud_image" "image1" {
  with_selector = "is_custom==true"
  most_recent   = true
}

resource "hcloud_firewall" "firewall1" {
  name = "default_firewall"
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

resource "hcloud_server" "node1" {
  name         = "node1"
  server_type  = "cx11"
  ssh_keys     = [resource.hcloud_ssh_key.default.id]
  firewall_ids = [hcloud_firewall.firewall1.id]
  image        = data.hcloud_image.image1.id
}

resource "cloudflare_zone" "digraph_me" {
  zone = "digraph.me"
  type = "full"
  plan = "free"
}

resource "cloudflare_record" "digraph_me" {
  name    = "@"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = hcloud_server.node1.ipv4_address
  zone_id = cloudflare_zone.digraph_me.id
}

resource "cloudflare_record" "raw_digraph_me" {
  name    = "raw"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = hcloud_server.node1.ipv4_address
  zone_id = cloudflare_zone.digraph_me.id
}
