
#  check your AWS Console to check your default region

provider "aws" {
   region     = "us-east-1"   
}
# can find the AMI under "Launch Instance"
resource "aws_instance" "terraformssh" {
    ami = "ami-05fa00d4c63e32376"
    instance_type = "t2.micro" 
    key_name= "aws_key"
    vpc_security_group_ids = [aws_security_group.main.id]


  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "jasmyns"
      private_key = file("/home/users/Jasmyns/.ssh/id_rsa")
      timeout     = "4m"
   }
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ] #add comp IP
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  }
  ]
}


resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDS0fRKfu1wh8OJ7lXhanJmSVpw/Au4WKgNcrCZCttAd50O/aNHdK2/29bSJ393T27aiytBPmwKv1wN46WCo7WS6Sn9SkEZBjk6eXjFhL2fFuqQkHpyLPiNxBIeYnODC3CsjnvA0HbNei/e/VbD7Q4ee7xjQE5m9QPxGV1tSpf61u4OIzYfYVCH26MOt7rIZaWXyvGItIzk9ugSsxqMB2mAe/7Q7lDVOY7+gYDWnBTFPPMisQySMRhoxqzzb4NCInabvi1jw69cOwNHxQSRdL5/XgTDpT7jlY+ZIOYXidtvvMPLpFB2oUIDptQk/LT2p39qaKT/tW9L1lQkU5904ZSRbGHDrUHuFXVhHs7ZX+Vc5iPNh6Tdh6WkTfnLYyAlrVx9ktGnvmAhxl2aZ4fUPgjOoF+fUBLo/0tWsbTALQNM3MjWwt0I2VFR8azu+OaeOk4AEShNBtOb1o5OKa3HNjnCwXxSTT6djGz7tEPLinY4L1KxcFr7P5ILbKbWDqLZ7MM= jasmyns@JasmynScBookPro.attlocal.net"
}

#ssh -i "/Users/JasmynS/.ssh/id_rsa"  ec2-user@ec2-18-188-95-83.us-east-2.compute.amazonaws.com