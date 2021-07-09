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
