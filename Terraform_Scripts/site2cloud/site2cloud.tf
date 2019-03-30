## Creates and manages an Aviatrix Site2Cloud connection

# Create Aviatrix AWS gateway to act as our "Local"
resource "aviatrix_gateway" "test_gateway1" {
  cloud_type = 1
  account_name = "devops"
  gw_name = "avxPrimaryGwName"
  vpc_id = "vpc-abcdef"
  vpc_reg = "us-west-1"
  vpc_size = "t2.micro"
  vpc_net = "10.20.1.0/24"
  allocate_new_eip = "off"
  eip = "6.6.6.6"
  # peering_ha_subnet = xxxx # uncomment before creation to test s2c ha_enabled
  # peering_ha_eip = xxxx # uncomment before creation to test s2c ha_enabled
}

# Create Aviatrix AWS gateway to act as our on-prem / "Remote" server
resource "aviatrix_gateway" "test_gateway2" {
  cloud_type = 1
  account_name = "devops"
  gw_name = "avtxgw2"
  vpc_id = "vpc-ghijkl"
  vpc_reg = "us-east-1"
  vpc_size = "t2.micro"
  vpc_net = "10.23.0.0/24"
  allocate_new_eip = "off"
  eip = "5.5.5.5"
  # peering_ha_subnet = xxxx # uncomment before creation to test s2c ha_enabled = "yes"
  # peering_ha_eip = xxxx  # uncomment before creation to test s2c ha_enabled = "yes"
}

resource "aviatrix_site2cloud" "s2c_test" {
  vpc_id = "${var.aws_vpc_id}"
  connection_name = "${var.avx_s2c_conn_name}"
  connection_type = "${var.avx_s2c_conn_type}"
  remote_gateway_type = "${var.remote_gw_type}" # "generic", "avx", "aws", "azure", "sonicwall"
  tunnel_type = "${var.avx_s2c_tunnel_type}" # "udp" , "tcp"
  ha_enabled = "${var.ha_enabled}" # (Optional) "yes" or "no"

  primary_cloud_gateway_name = "${var.avx_gw_name}" # local gw name
  # backup_gateway_name = "${var.avx_gw_name_backup}" # uncomment before creation to test s2c ha_enabled = "yes"
  remote_gateway_ip = "${var.remote_gw_ip}"
  # backup_remote_gateway_ip = "${var.remote_gw_ip_backup}" # uncomment before creation to test s2c ha_enabled = "yes"
  # pre_shared_key = "${var.pre_shared_key}" # (Optional) Auto-generated if not specified
  # backup_pre_shared_key = "${var.pre_shared_key_backup}" # (Optional) # can uncomment before creation to test s2c ha_enabled = "yes"
  remote_subnet_cidr = "${var.remote_subnet_cidr}" # on-prem's subnet cidr
  local_subnet_cidr = "${var.local_subnet_cidr}" # (Optional)

  depends_on = ["aviatrix_gateway.test_gateway1", "aviatrix_gateway.test_gateway2"]
}