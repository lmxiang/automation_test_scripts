## Test case 1: Enable Single AZ HA

gw_size               = "c5.large" ## insane mode must be c5 series
aviatrix_ha_gw_size   = "c5.large"

single_az_ha                  = true
tgw_enable_hybrid             = true
tgw_enable_connected_transit  = true

enable_vpc_dns_server = false
