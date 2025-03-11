provider "aws" {
  region = var.aws_region
}

module "ec2_instance" {
  source = "./modules/aws"
  
  instance_type    = var.instance_type
  key_name         = var.key_name
  private_key_path = var.private_key_path
  app_name         = var.app_name
  environment      = var.environment
}

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/templates/inventory.tmpl", {
    ip_address = module.ec2_instance.public_ip
    ssh_user   = "ubuntu"
    key_file   = var.private_key_path
  })
  filename = "${path.module}/../ansible/inventory.yml"
}

resource "null_resource" "run_ansible" {
  depends_on = [
    local_file.ansible_inventory,
    module.ec2_instance
  ]
  
  # Add a provisioner to wait for SSH to be available
  provisioner "local-exec" {
    command = "sleep 90"  # Wait 90 seconds for the instance to boot fully
  }
  
  provisioner "local-exec" {
    command = "cd ${path.module}/../ansible && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory.yml playbook.yml"
    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "False"
    }
  }
}