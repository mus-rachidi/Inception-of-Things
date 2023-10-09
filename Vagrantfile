Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/bionic64"

  config.vm.provider "virtualbox" do |v|
		v.memory = 1024
		v.cpus = 1
	end

  config.vm.define "userS" do |master|
    master.vm.hostname = "userS"
    master.vm.network :private_network, ip: "192.168.58.140"
    master.vm.synced_folder ".", "/vagrant", type: "virtualbox"
    master.vm.provision "shell" do |s|
      s.privileged = true # Run the script as root
      s.inline = <<-SHELL
      sudo sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
      sudo systemctl restart ssh
      export INSTALL_K3S_EXEC="server --write-kubeconfig-mode 644  --advertise-address=192.168.58.140 --node-ip=192.168.58.140"
      curl -sfL https://get.k3s.io |  sh -
      cp /var/lib/rancher/k3s/server/node-token /vagrant/
      echo "alias k='k3s kubectl'" >> /etc/profile.d/apps-bin-path.sh
      kubectl apply -f /vagrant/config/app1-deployment.yaml
      kubectl apply -f /vagrant/config/app1-service.yaml
      kubectl apply -f /vagrant/config/app2-deployment.yaml
      kubectl apply -f /vagrant/config/app2-service.yaml
      kubectl apply -f /vagrant/config/app3-deployment.yaml
      kubectl apply -f /vagrant/config/app3-service.yaml
      kubectl apply -f /vagrant/config/ingress.yaml
      SHELL
    end
  end

  config.vm.define "userSW" do |worker|
    worker.vm.hostname = "userSW"
    worker.vm.network :private_network, ip: "192.168.58.141" 
    worker.vm.synced_folder ".", "/vagrant", type: "virtualbox"
    worker.vm.provision "shell" do |s|
      s.privileged = true # Run the script as root
      s.inline = <<-SHELL
      sudo sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
      sudo systemctl restart ssh
      export INSTALL_K3S_EXEC="agent --server https://192.168.58.140:6443 --token-file /vagrant/node-token --node-ip=192.168.58.141"
      curl -sfL https://get.k3s.io |  sh -
      SHELL
    end
  end
end