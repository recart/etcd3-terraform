data "template_file" "cloud-init" {
  template = "${file("${path.module}/cloudinit/userdata-template.json")}"

  vars {
    download_cfssl_unit = "${data.template_file.download_cfssl_unit.rendered}"
    cfssl_unit          = "${data.template_file.cfssl_unit.rendered}"
    ntpdate_unit        = "${data.template_file.ntpdate_unit.rendered}"
    ntpdate_timer_unit  = "${data.template_file.ntpdate_timer_unit.rendered}"
 }
}

data "template_file" "download_cfssl_unit" {
  template = "${file("${path.module}/cloudinit/download_cfssl_unit")}"
}

data "template_file" "cfssl_unit" {
  template = "${file("${path.module}/cloudinit/cfssl_unit")}"

  vars {
    s3_bucket = "${var.s3_bucket}"
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
