provider "cloudflare" {}

data "cloudflare_zone" "digraph_me" {
  filter = { name = "digraph.me" }
}

resource "cloudflare_dns_record" "digraph_me" {
  name    = "digraph.me"
  proxied = true
  ttl     = 1
  type    = "A"
  content = hcloud_server.webserver.ipv4_address
  zone_id = data.cloudflare_zone.digraph_me.zone_id
}

resource "cloudflare_dns_record" "raw_digraph_me" {
  name    = "raw.digraph.me"
  proxied = false
  ttl     = 1
  type    = "A"
  content = hcloud_server.webserver.ipv4_address
  zone_id = data.cloudflare_zone.digraph_me.zone_id
}

resource "cloudflare_dns_record" "google_search_digraph_me" {
  name    = "digraph.me"
  ttl     = 1
  type    = "TXT"
  content = "google-site-verification=FfBK-ilG6TZVxXRvPXxuB77Mn9xz8FuJJcBIZYOXgX0"
  zone_id = data.cloudflare_zone.digraph_me.zone_id
}

resource "cloudflare_page_rule" "page_rules_digraph_me" {
  zone_id  = data.cloudflare_zone.digraph_me.zone_id
  target   = "digraph.me/*"
  status   = "active"
  priority = 1

  actions = {
    cache_level              = "basic"
    automatic_https_rewrites = "off"
  }

  lifecycle { ignore_changes = [target, actions] }
}
