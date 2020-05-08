terraform {
  required_version = ">= 0.12"
}

locals {
  albelli_ranges = [
    "185.184.204.70/32", # Office AMS
    "62.97.245.10/32",   # Office BGO
    "185.184.204.74/32", # Office HAG
    "62.102.226.22/32",  # Office NLH
    "89.91.227.16/32",   # Office NLH
    "213.41.124.76/32",  # Office PAR
    "77.60.83.148/32",   # Datacenter ALM
    "62.21.226.193/32",  # Datacenter ALM
    "192.168.0.0/16",    # Internal Network
    "10.0.0.0/8",        # Internal Network
    "172.16.0.0/12",     # Internal Network
  ]
}
