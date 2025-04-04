# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"
  config.vm.network "forwarded_port", guest: 80, host: 80
  config.vm.network "forwarded_port", guest: 443, host: 443
  config.vm.network "forwarded_port", guest: 8000, host: 8000, host_ip: "0.0.0.0", id: "ssh"
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.box_check_update = false
  config.vbguest.auto_update = false

  config.vm.synced_folder ".", "/opt/myapp",
    type: "rsync",
    rsync__exclude: [".git/", ".env/", "__pycache__/", "*.sqlite3"],
    rsync__args: ["--verbose", "--archive", "--delete", "--copy-links"],
    rsync__auto: true

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 2048
    vb.cpus = 2
  end
end
