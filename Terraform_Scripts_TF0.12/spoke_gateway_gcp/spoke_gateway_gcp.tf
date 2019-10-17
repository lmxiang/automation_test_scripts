# Manage Aviatrix spoke_gateway (Gcloud)

resource "aviatrix_transit_gateway" "gcloud_transit_gw1" {
  cloud_type          = 4
  account_name        = "GCPAccess"
  gw_name             = "gcloudtransitgw1"
  vpc_id              = "gcptestvpc"
  vpc_reg             = "us-central1-c"
  gw_size             = "n1-standard-1"
  subnet              = "10.128.0.0/20"
  ha_zone             = "us-central1-a"
  ha_gw_size          = "n1-standard-1"
  enable_snat         = true
  connected_transit   = true
  enable_active_mesh  = false
}

resource "aviatrix_transit_gateway" "gcloud_transit_gw2" {
  cloud_type          = 4
  account_name        = "GCPAccess"
  gw_name             = "gcloudtransitgw2"
  vpc_id              = "gcptransitvpc"
  vpc_reg             = "us-east4-a"
  gw_size             = "n1-standard-1"
  subnet              = "172.21.0.0/16"
  ha_zone             = "us-east4-b"
  ha_gw_size          = "n1-standard-1"
  enable_snat         = true
  connected_transit   = true
  enable_active_mesh  = false
}

resource "aviatrix_spoke_gateway" "gcloud_spoke_gw" {
  cloud_type      = 4
  account_name    = "GCPAccess"
  gw_name         = "gcloudspokegw"
  vpc_id          = "gcpspokevpc"
  vpc_reg         = "us-west2-c"
  gw_size         = var.gcp_instance_size
  subnet          = "172.23.0.0/16"

  ha_zone         = var.gcp_ha_gw_zone
  ha_gw_size      = var.gcp_ha_gw_size
  enable_snat     = var.toggle_snat
  enable_active_mesh = false
  transit_gw      = var.attached_transit_gw
  depends_on      = ["aviatrix_transit_gateway.gcloud_transit_gw1", "aviatrix_transit_gateway.gcloud_transit_gw2"]
}
