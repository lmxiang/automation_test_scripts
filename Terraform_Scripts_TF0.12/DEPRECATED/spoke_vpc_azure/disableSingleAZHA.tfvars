## Test Case 1: Disable single AZHA

arm_gw_size         = "Standard_B1s"

arm_ha_gw_subnet    = ""
arm_ha_gw_size      = ""

toggle_snat         = "yes"
toggle_single_az_ha = "disabled" # enabled -> disabled

attached_transit_gw = ""
