#Creates a Windows 2019 Server using latest available Windows 2019 Image
#Latest image determined at runtime

data "aws_ami" "windows-2019" {
  most_recent = true
  owners = ["amazon"]
  
  filter {
      name   = "name"
      values = ["Windows_Server-2019-English-Full-Base*"]
  }
  filter {
      name   = "root-device-type"
      values = ["ebs"]
  }
  filter {
      name   = "virtualization-type"
      values = ["hvm"]
  }
  filter {
      name   = "architecture"
      values = ["x86_64"]
  }
}

