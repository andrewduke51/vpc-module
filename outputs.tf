output "vpc_id" {
  value = "${aws_vpc.main_vpc.id}"
}

output "subnet_dmz" {
  value = "${aws_subnet.subnet_dmz.id}"
}

output "subnet_internal" {
  value = "${aws_subnet.subnet_internal.id}"
}

output "nat_gateway_id" {
  value = "${aws_nat_gateway.aws_nat_gateway.id}"
}

output "nat_gateway_eni" {
  value = "${aws_nat_gateway.aws_nat_gateway.network_interface_id}"
}