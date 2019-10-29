## Test case: test vpn gateway

resource "aviatrix_gateway" "testGW2" {
  cloud_type        = 1
  account_name      = "AWSAccess"
  gw_name           = "testGW2"
  vpc_id            = "vpc-ba3c12dd"
  vpc_reg           = "us-west-1"
  gw_size           = "t2.micro"
  subnet            = "172.31.0.0/20"

  single_az_ha      = var.aviatrix_single_az_ha
  allocate_new_eip  = true

  vpn_access        = true
  vpn_cidr          = var.aviatrix_vpn_cidr
  enable_elb        = true
  elb_name          = "elb-testgw2-vpn"
  max_vpn_conn      = var.aviatrix_vpn_max_conn

  split_tunnel      = var.aviatrix_vpn_split_tunnel
  search_domains    = var.aviatrix_vpn_split_tunnel_search_domain_list
  additional_cidrs  = var.aviatrix_vpn_split_tunnel_additional_cidrs_list
  name_servers      = var.aviatrix_vpn_split_tunnel_name_servers_list

  saml_enabled      = true

}

## (11332) vpn gw needs to support workflow for multiple gw under same ELB
# resource "aviatrix_gateway" "vpnGWunderELB2" {
#   cloud_type        = 1
#   account_name      = "AWSAccess"
#   gw_name           = "vpnGWunderELB2"
#   vpc_id            = aviatrix_gateway.vpnGWunderELB.vpc_id
#   vpc_reg           = aviatrix_gateway.vpnGWunderELB.vpc_reg
#
#   # v2
#   gw_size           = "t2.micro"
#   subnet            = aviatrix_gateway.vpnGWunderELB.subnet
#
#   single_az_ha      = true
#   allocate_new_eip  = true
#
#   vpn_access        = true
#   vpn_cidr          = "192.168.44.0/24"
#   enable_elb        = true
#   enable_vpn_nat    = true
#   elb_name          = aviatrix_gateway.vpnGWunderELB.elb_name
#   max_vpn_conn      = var.aviatrix_vpn_max_conn
#
#   split_tunnel      = var.aviatrix_vpn_split_tunnel
#   search_domains    = var.aviatrix_vpn_split_tunnel_search_domain_list
#   additional_cidrs  = var.aviatrix_vpn_split_tunnel_additional_cidrs_list
#   name_servers      = var.aviatrix_vpn_split_tunnel_name_servers_list
#
#   saml_enabled      = true
#
# }
