source "virtualbox-iso" "step_1" {
  boot_command     = ["<esc><wait>", "<esc><wait>", "<enter><wait>",
                      "/install/vmlinuz<wait>", " initrd=/install/initrd.gz",
                      " auto-install/enable=true", " debconf/priority=critical",
                      " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ubuntu_preseed.cfg<wait>",
                      " -- <wait>", "<enter><wait>"]
  disk_size        = "40960"
  guest_os_type    = "Ubuntu_64"
  http_directory   = "./http"
  iso_checksum     = "sha256:946a6077af6f5f95a51f82fdc44051c7aa19f9cfc5f737954845a6050543d7c2"
  iso_url          = "http://old-releases.ubuntu.com/releases/14.04.1/ubuntu-14.04-server-amd64.iso"
  shutdown_command = "echo 'vagrant' | sudo -S shutdown -P now"
  ssh_password     = "vagrant"
  ssh_port         = 22
  ssh_username     = "vagrant"
  vm_name          = "vbox-example"
}
build {
  sources = ["source.virtualbox-iso.step_1"]


  provisioner "shell" {
    inline = ["echo initial provisioning"]
  }
  post-processor "manifest" {
    output = "stage-1-manifest.json"
  }
}