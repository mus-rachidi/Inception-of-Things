Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/mantic64"

  config.vm.provider "virtualbox" do |v|
		v.memory = 1024
		v.cpus = 1
	end

  config.vm.define "userS" do |master|
    master.vm.hostname = "userS"
    master.vm.network :private_network, ip: "192.168.56.110"
    master.vm.synced_folder ".", "/home/vagrant", type: "virtualbox"
    master.vm.provision "shell", inline: <<-SHELL
    export INSTALL_K3S_EXEC="--write-kubeconfig-mode=644 --tls-san $(hostname) --node-ip 192.168.56.110  --bind-address=192.168.56.110 --advertise-address=192.168.56.110"
    curl -sfL https://get.k3s.io |  sh -
    # sudo scp /var/lib/rancher/k3s/server/node-token vagrant@userSW:/home/vagrant/
    sudo sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
    sudo systemctl restart ssh
  SHELL
  end

  config.vm.define "userSW" do |worker|
    worker.vm.hostname = "userSW"
    worker.vm.network :private_network, ip: "192.168.56.111" 
    worker.vm.synced_folder ".", "/home/vagrant", type: "virtualbox"
    worker.vm.provision "shell", inline: <<-SHELL
    # export TOKEN_FILE="/vagrant/node-token"
    # export INSTALL_K3S_EXEC="agent --server https://192.168.56.110:6443 --token-file $TOKEN_FILE --node-ip=192.168.56.111"
    # curl -sfL https://get.k3s.io |  sh -
    sudo sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
    sudo systemctl restart ssh
  SHELL
  end

end