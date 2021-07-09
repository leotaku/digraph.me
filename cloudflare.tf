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
  zone_id = cloudflare_zone.digraph_me.id
  value   = hcloud_server.webserver.ipv4_address
}

resource "cloudflare_record" "raw_digraph_me" {
  name    = "raw"
  proxied = false
  ttl     = 1
  type    = "A"
  zone_id = cloudflare_zone.digraph_me.id
  value   = hcloud_server.webserver.ipv4_address
}
