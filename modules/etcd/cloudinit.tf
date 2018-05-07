data "template_file" "cloud-init" {
  count    = "${var.cluster_size}"
  template = "${file("${path.module}/cloudinit/userdata-template.json")}"

  vars {
    environment = "${var.environment}"
    role        = "${var.role}"
    region      = "${var.region}"

    etcd_member_unit    = "${element(data.template_file.etcd_member_unit.*.rendered, count.index)}"
    etcd_bootstrap_unit = "${element(data.template_file.etcd_bootstrap_unit.*.rendered, count.index)}"
    ntpdate_unit        = "${data.template_file.ntpdate_unit.rendered}"
    ntpdate_timer_unit  = "${data.template_file.ntpdate_timer_unit.rendered}"
    download_cfssl_unit = "${data.template_file.download_cfssl_unit.rendered}"
    certificate_unit    = "${data.template_file.certificate_unit.rendered}"
    environment_file    = "${element(data.template_file.environment_file.*.rendered, count.index)}"
  }
}

data "template_file" "environment_file" {
  count    = "${var.cluster_size}"
  template = "${file("${path.module}/cloudinit/environment_file")}"

  vars {
    peer_name             = "peer-${count.index}"
    discovery_domain_name = "${var.role}.${var.region}.i.${var.environment}.${var.dns["domain_name"]}"
    cluster_name          = "${var.role}"
  }
}

data "template_file" "etcd_member_unit" {
  count    = "${var.cluster_size}"
  template = "${file("${path.module}/cloudinit/etcd_member_unit")}"

  vars {
    peer_name             = "peer-${count.index}"
    discovery_domain_name = "${var.role}.${var.region}.i.${var.environment}.${var.dns["domain_name"]}"
    cluster_name          = "${var.role}"
  }
}

data "template_file" "etcd_bootstrap_unit" {
  count    = "${var.cluster_size}"
  template = "${file("${path.module}/cloudinit/etcd_bootstrap_unit")}"

  vars {
    region                = "${var.region}"
    peer_name             = "peer-${count.index}"
    discovery_domain_name = "${var.role}.${var.region}.i.${var.environment}.${var.dns["domain_name"]}"
    s3_bucket             = "${var.s3_bucket}"
  }
}

data "template_file" "download_cfssl_unit" {
  template = "${file("${path.module}/cloudinit/download_cfssl_unit")}"
}

data "template_file" "certificate_unit" {
  template = "${file("${path.module}/cloudinit/certificate_unit")}"

  vars {
    s3_pki_bucket         = "${var.s3_pki_bucket}"
    peer_name             = "peer-${count.index}"
    pki_host              = "pki.${var.region}.i.${var.environment}.${var.dns["domain_name"]}"
    discovery_domain_name = "${var.role}.${var.region}.i.${var.environment}.${var.dns["domain_name"]}"
  }
}

data "template_file" "ntpdate_unit" {
  template = "${file("${path.module}/cloudinit/ntpdate_unit")}"

  vars {
    ntp_host = "${var.ntp_host}"
  }
}

data "template_file" "ntpdate_timer_unit" {
  template = "${file("${path.module}/cloudinit/ntpdate_timer_unit")}"
}
