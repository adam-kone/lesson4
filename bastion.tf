resource "oci_core_instance" "bastion" {
  availability_domain = var.ads[2]
  compartment_id = var.compartment_id
  fault_domain = "FAULT-DOMAIN-1"
  shape = var.shapes
  display_name = "bastion"
  source_details {
    source_id = var.images
    source_type = "image"
  }
  create_vnic_details {
    subnet_id = oci_core_subnet.subnet1.id
    assign_public_ip = true
  }
  metadata = {
    ssh_authorized_keys= "${file("${var.ssh_authorized_keys}")}"
  }
}
data "oci_core_vnic_attachments" "vnic-attachment" {
  compartment_id = var.compartment_id
  availability_domain = var.ads[0]
  instance_id = oci_core_instance.webserver.id
}

