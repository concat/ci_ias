resource "aws_route53_record" "theseRecords" {
  count = "${length(var.myFQDNs)}"
  provider =  "aws.primary"

  zone_id = "${var.myRoute53HostedZoneId}"
  name = "${var.myFQDNs[count.index]}"
  type = "A"

  alias {
    name = "${var.myALBDNSName}"
    zone_id = "${var.myALBZoneId}"
    evaluate_target_health = false
  } 
}