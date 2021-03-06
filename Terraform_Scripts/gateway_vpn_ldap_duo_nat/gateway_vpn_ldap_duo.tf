# Create Aviatrix gateway in AWS public cloud

resource "aviatrix_gateway" "aws_gateway" {
              cloud_type = "${var.aviatrix_cloud_type_aws}"
            account_name = "${var.aviatrix_cloud_account_name}"
                 gw_name = "${var.aviatrix_gateway_name}"
              enable_nat = "${var.aviatrix_enable_nat}"
                  vpc_id = "${var.aws_vpc_id}"
                 vpc_reg = "${var.aws_region}"
                vpc_size = "${var.aws_instance}"
                 vpc_net = "${var.aws_vpc_public_cidr}"
              vpn_access = "${var.aviatrix_vpn_access}"
                vpn_cidr = "${var.aviatrix_vpn_cidr}"
            split_tunnel = "${var.aviatrix_vpn_split_tunnel}"
              enable_elb = "${var.aviatrix_vpn_elb}"
                otp_mode = "${var.aviatrix_vpn_otp_mode}"
     duo_integration_key = "${var.aviatrix_vpn_duo_integration_key}"
          duo_secret_key = "${var.aviatrix_vpn_duo_secret_key}"
        duo_api_hostname = "${var.aviatrix_vpn_duo_api_hostname}"
           duo_push_mode = "${var.aviatrix_vpn_duo_push_mode}"
             enable_ldap = "${var.aviatrix_vpn_ldap_enable}"
             ldap_server = "${var.aviatrix_vpn_ldap_server}"
            ldap_bind_dn = "${var.aviatrix_vpn_ldap_bind_dn}"
           ldap_password = "${var.aviatrix_vpn_ldap_password}"
            ldap_base_dn = "${var.aviatrix_vpn_ldap_base_dn}"
 ldap_username_attribute = "${var.aviatrix_vpn_ldap_username_attribute}"
}
