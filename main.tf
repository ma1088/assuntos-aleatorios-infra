variable "instance_names"{
    type = list(string)
    default = [
        "ec2_pauta"
    ]
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "instancias_ec2"{
    count = 1
    ami = "ami-08c40ec9ead489470"
    instance_type = "t2.micro"
    key_name = "admin_terraform-key-pair"
    tags = {
        Name = var.instance_names[count.index]
        Environment = "dev"
    }

    vpc_security_group_ids = [
        "sg-0e1db5044066af2d5", #default
        "sg-0bdce8f6198ae8204" #abre porta 3306
    ]

    user_data = file("ec2/01.setup_docker.sh")
}
