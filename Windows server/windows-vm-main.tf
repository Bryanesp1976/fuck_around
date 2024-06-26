# Bootstrapping PowerShell Script
data "template_file" "windows-userdata" {
  template = <<EOF
<powershell>
# Rename Machine
Rename-Computer -NewName "${var.windows_instance_name}" -Force;# Install IIS
Install-WindowsFeature -name Web-Server -IncludeManagementTools;# Restart machine
shutdown -r -t 10;
</powershell>
EOF
}
# Define the security group for the Windows server
resource "aws_security_group" "aws-windows-sg" {
  name        = "windows-sg"
  description = "Allow incoming connections"
  vpc_id      = var.a_vpc_id  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["3.83.200.219/32"]
    description = "Allow incoming HTTP connections"
  }  
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["3.83.200.219/32"]
    description = "Allow incoming RDP connections"
  }  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }  
  tags = {
    Name = "windows-sg"
  }
}
# Create EC2 Instance
resource "aws_instance" "windows-server" {
  ami = data.aws_ami.windows-2019.id
  instance_type = var.windows_instance_type
  subnet_id = var.public_subnet_id 
  vpc_security_group_ids = [aws_security_group.aws-windows-sg.id]
  source_dest_check = false
  key_name = aws_key_pair.key_pair.key_name
  user_data = data.template_file.windows-userdata.rendered 
  associate_public_ip_address = var.windows_associate_public_ip_address
  
  # root disk
  root_block_device {
    volume_size           = var.windows_root_volume_size
    volume_type           = var.windows_root_volume_type
    delete_on_termination = true
    encrypted             = true
  }  # extra disk
  ebs_block_device {
    device_name           = "/dev/xvda"
    volume_size           = var.windows_data_volume_size
    volume_type           = var.windows_data_volume_type
    encrypted             = true
    delete_on_termination = true
  }
  
  tags = {
    Name        = "windows-server-vm"
  }
}
