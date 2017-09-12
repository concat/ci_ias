resource "aws_route" "NATGatewayRoute" {
	provider =  "aws.primary" 
	count = "${var.myRTQty}"

    route_table_id = "${var.myRoutetableIds[count.index]}"
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${var.myNATGatewayIds[count.index]}"
}