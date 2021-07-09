data "cloudflare_zones" "digraph_me" {
  filter {
    name = "digraph.me"
    status = "active"
  }
}

resource "cloudflare_record" "digraph_me" {
  name    = "@"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = hcloud_server.webserver.ipv4_address
  zone_id = data.cloudflare_zones.digraph_me.zones[0].id
}

resource "cloudflare_record" "raw_digraph_me" {
  name    = "raw"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = hcloud_server.webserver.ipv4_address
  zone_id = data.cloudflare_zones.digraph_me.zones[0].id
}
