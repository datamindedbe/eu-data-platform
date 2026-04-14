resource "ionoscloud_datacenter" "frankfurt" {
  name                    = "dp-ionos-frankfurt"
  location                = "de/fra"
  description             = "Datacenter for frankfurt region"
}

resource "ionoscloud_lan"  "frankfurt_public" {
  datacenter_id           = ionoscloud_datacenter.frankfurt.id
  public                  = true
  name                    = "frankfurt-lan"
}


resource "ionoscloud_lan"  "frankfurt_private" {
  datacenter_id           = ionoscloud_datacenter.frankfurt.id
  public                  = false
  name                    = "frankfurt-lan"
}

resource "ionoscloud_ipblock" "db_nlb" {
  location  = "de/fra"
  size      = 1
  name      = "db IP Block"
}