
resource "aws_route_table_association" "routetable4subnet" {
	provider =  "aws.primary"
	count = "${var.myRTAssocQty}"

	subnet_id = "${var.mySubnetsId[count.index]}"
	route_table_id = "${var.myRoutetablesId[count.index]}"
}

# resource "aws_route_table_association" "routetable4subnet0" {
#   provider =  "aws.primary"
# #  count = "${var.myRTAssocQty}"

#   subnet_id = "${var.mySubnetsId[0]}"
#   route_table_id = "${var.myRoutetablesId[0]}"
# }

# resource "aws_route_table_association" "routetable4subnet1" {
#   provider =  "aws.primary"
# # count = "${var.myRTAssocQty}"

#   subnet_id = "${var.mySubnetsId[1]}"
#   route_table_id = "${var.myRoutetablesId[1]}"
# }