resource "aws_instance" "main" {
  ami           = "ami-02a599eb01e3b3c5b"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.app.id}"]
  key_name = "${var.ssh_key_name}"
  subnet_id = "${aws_subnet.main.id}"
  depends_on = [aws_db_instance.postgresdb]
  
  provisioner "file" {
    source = "./deploy.sh"
    destination = "/home/ubuntu/deploy.sh"
    connection {
      type = "ssh"
      user = "ubuntu"
      host = "${self.public_ip}"
      private_key = "${file("${var.ssh_key_path}")}"  
    }
  }

  provisioner "file" {
    source = "./docker.sh"
    destination = "/home/ubuntu/docker.sh"
    connection {
      type = "ssh"
      user = "ubuntu"
      host = "${self.public_ip}"
      private_key = "${file("${var.ssh_key_path}")}"  
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/deploy.sh",
      "chmod +x /home/ubuntu/docker.sh",
    ]
    connection {
      type = "ssh"
      user = "ubuntu"
      host = "${self.public_ip}"
      private_key = "${file("${var.ssh_key_path}")}"  
    }
  }

  tags = { 
    Name = "application"
  }
}


