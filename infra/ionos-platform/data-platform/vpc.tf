resource "ionoscloud_datacenter" "frankfurt" {
  name                    = "dp-ionos-frankfurt"
  location                = "de/fra"
  description             = "Datacenter for frankfurt region"
}

resource "ionoscloud_lan"  "frankfurt_private" {
  datacenter_id           = ionoscloud_datacenter.frankfurt.id
  public                  = false
  name                    = "frankfurt-lan" #10.7.222.0/23
  # Get the lan cidr after applying as it is needed for database connection, you cannot specify it beforehand
}

resource "ionoscloud_ipblock" "db_nlb" {
  location  = "de/fra"
  size      = 1
  name      = "db IP Block"
}