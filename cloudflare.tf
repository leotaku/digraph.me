provider "cloudflare" {}

data "cloudflare_zone" "digraph_me" {
  name   = "digraph.me"
}

resource "cloudflare_record" "digraph_me" {
  name    = "@"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = hcloud_server.webserver.ipv4_address
  zone_id = data.cloudflare_zone.digraph_me.id
}

resource "cloudflare_record" "raw_digraph_me" {
  name    = "raw"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = hcloud_server.webserver.ipv4_address
  zone_id = data.cloudflare_zone.digraph_me.id
}

resource "cloudflare_record" "google_search_digraph_me" {
  name    = "@"
  ttl     = 1
  type    = "TXT"
  value   = "google-site-verification=FfBK-ilG6TZVxXRvPXxuB77Mn9xz8FuJJcBIZYOXgX0"
  zone_id = data.cloudflare_zone.digraph_me.id
}

resource "cloudflare_page_rule" "page_rules_digraph_me" {
  zone_id  = data.cloudflare_zone.digraph_me.id
  target   = "digraph.me/*"
  priority = 1

  actions {
    cache_level = "cache_everything"
    automatic_https_rewrites = "off"
  }
}
