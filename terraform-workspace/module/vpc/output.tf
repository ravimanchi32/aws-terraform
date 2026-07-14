
# output value vpe id
output "vpc" {
    value = aws_vpc.myvpc
}

# public subnet
output "subnet" {
    value = aws_subnet.public_sub
}