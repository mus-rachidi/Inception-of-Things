Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"

  config.vm.provider "virtualbox" do |v|
		v.memory = 1024
		v.cpus = 1
	end

  config.vm.define "userS" do |master|
    master.vm.hostname = "userS"
    master.vm.network :private_network, ip: "192.168.56.110"
    master.vm.synced_folder ".", "/vagrant", type: "virtualbox"
    master.vm.provision "shell" do |s|
      s.privileged = true # Run the script as root
      s.inline = <<-SHELL
      sudo sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
      sudo systemctl restart ssh
      export INSTALL_K3S_EXEC="server --write-kubeconfig-mode 644 --advertise-address=192.168.56.110 --node-ip=192.168.56.110"
      curl -sfL https://get.k3s.io |  sh -
      cp /var/lib/rancher/k3s/server/node-token /vagrant/node-token  
      SHELL
    end
  end

  config.vm.define "userSW" do |worker|
    worker.vm.hostname = "userSW"
    worker.vm.network :private_network, ip: "192.168.56.111" 
    worker.vm.synced_folder ".", "/vagrant", type: "virtualbox"
    worker.vm.provision "shell" do |s|
      s.privileged = true # Run the script as root
      s.inline = <<-SHELL
      sudo sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
      sudo systemctl restart ssh
      export INSTALL_K3S_EXEC="agent --server https://192.168.56.110:6443 --token-file /vagrant/node-token --node-ip=192.168.56.111"
      curl -sfL https://get.k3s.io |  sh -
      SHELL
    end
  end
end