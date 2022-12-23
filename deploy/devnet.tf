// https://slugs.do-api.dev/

resource "digitalocean_droplet" "sn_devnet" {
  image  = "docker-20-04"
  name   = "starknet-devnet"
  region = "ams3"
  size   = "s-1vcpu-1gb"
  ssh_keys = [
    data.digitalocean_ssh_key.tf_ssh_key.id
  ]

  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    private_key = file(var.pvt_key)
    timeout     = "2m"
  }

  provisioner "file" {
    source      = "docker-compose.yml"
    destination = "docker-compose.yml"
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo apt update",
      "sudo apt-get install -y docker-compose-plugin",
      "sudo ufw allow 5050",
      "sudo ufw allow 7171/tcp",
      "sudo docker compose up --detach"
    ]
  }
}

output "ip_address" {
  value = digitalocean_droplet.sn_devnet.ipv4_address
}