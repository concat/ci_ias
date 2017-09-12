resource "aws_route" "igwroute" {
	provider =  "aws.primary" 	
	count = "${var.myRTQty}"

	route_table_id = "${var.myRoutetableIds[count.index]}"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = "${var.myIGWId}"
}