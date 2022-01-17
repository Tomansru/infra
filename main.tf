terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
    }
  }
  required_version = ">= 0.14"
}

# Set the variable value in *.tfvars file
# or using the -var="hcloud_token=..." CLI option
variable "hcloud_token" {
  sensitive = true # Requires terraform >= 0.14
}

# Configure the Hetzner Cloud Provider
provider "hcloud" {
  token = var.hcloud_token
}

# Create a virtual network
resource "hcloud_network" "kubnet" {
  name     = "kub-net"
  ip_range = "10.0.0.0/16"
}

resource "hcloud_network_subnet" "kubnet-subnet" {
  type         = "cloud"
  network_id   = hcloud_network.kubnet.id
  network_zone = "eu-central"
  ip_range     = "10.0.1.0/24"
}

# Create a servers
resource "hcloud_server" "kub1" {
  name        = "kub1"
  image       = "rocky-8"
  server_type = "cx21"
  location    = "fsn1"
  ssh_keys    = [
    "stas@OnePlus6T",
    "stanislav@StanislavPC",
    "stas@Stanislavs-MacBook-Pro.local"
  ]
  network {
    network_id = hcloud_network.kubnet.id
    ip         = "10.0.1.5"
  }
  depends_on = [
    hcloud_network_subnet.kubnet-subnet
  ]
}

resource "hcloud_server" "kub2" {
  name        = "kub2"
  image       = "rocky-8"
  server_type = "cx21"
  location    = "fsn1"
  ssh_keys    = [
    "stas@OnePlus6T",
    "stanislav@StanislavPC",
    "stas@Stanislavs-MacBook-Pro.local"
  ]
  network {
    network_id = hcloud_network.kubnet.id
    ip         = "10.0.1.6"
  }
  depends_on = [
    hcloud_network_subnet.kubnet-subnet
  ]
}

resource "hcloud_server" "kub3" {
  name        = "kub3"
  image       = "rocky-8"
  server_type = "cx21"
  location    = "fsn1"
  ssh_keys    = [
    "stas@OnePlus6T",
    "stanislav@StanislavPC",
    "stas@Stanislavs-MacBook-Pro.local"
  ]
  network {
    network_id = hcloud_network.kubnet.id
    ip         = "10.0.1.7"
  }
  depends_on = [
    hcloud_network_subnet.kubnet-subnet
  ]
}