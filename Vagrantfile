# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|


  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "bento/centos-7.2"

  # Disable automatic box update checking
  config.vm.box_check_update = false

  # Share an additional folder to the guest VM
  config.vm.synced_folder ".", "/vagrant_data"

  config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
   vb.memory = "512"
  end

  # provisioning with a shell script
  config.vm.provision "shell", path: "script.sh"
end
