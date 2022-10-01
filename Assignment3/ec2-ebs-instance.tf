provider "aws" {
  region = "ap-south-1"
}


resource "aws_security_group" "first-group-ssh-http" {
  name        = "first-group-ssh-http"
  description = "allow ssh and http traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}



resource "aws_instance" "instance-ssh-http" {
  ami               = "ami-5b673c34"
  instance_type     = "t2.micro"
  availability_zone = "ap-south-1a"
  security_groups   = ["${aws_security_group.first-group-ssh-http.name}"]
}




resource "aws_ebs_volume" "data-vol" {
 availability_zone = "ap-south-1a"
 size = 1
 tags = {
        Name = "data-volume"
 }

}

resource "aws_volume_attachment" "instance-ssh-http-vol" {
 device_name = "/dev/sdc"
 volume_id = "${aws_ebs_volume.data-vol.id}"
 instance_id = "${aws_instance.instance-ssh-http.id}"
}
