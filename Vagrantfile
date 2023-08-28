Vagrant.configure("2") do |config|
  config.vm.define "user1S" do |user1|
    user1.vm.network "private_network", type: "static",  ip: "192.168.56.110" , name: "eth1"  
    user1.vm.box = "ubuntu/mantic64"
    user1.vm.hostname = "user1S"
    user1.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.cpus = 1
    end
    user1.vm.provision "shell", inline: <<-SHELL
      # Allow passwordless SSH login
      sudo sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
      sudo systemctl restart ssh
    SHELL
  end

  config.vm.define "user1SW" do |user1sw|
    user1sw.vm.network "private_network", type: "static",  ip: "192.168.56.111" , name: "eth1"
    user1sw.vm.box = "ubuntu/mantic64"
    user1sw.vm.hostname = "user1SW"
    user1sw.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.cpus = 1
    end
    user1sw.vm.provision "shell", inline: <<-SHELL
      # Allow passwordless SSH login
      sudo sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
      sudo systemctl restart ssh
    SHELL
  end
    users = ["user1S", "user1SW"]  # Add the usernames you want to provision for

  users.each do |username|
    config.vm.define username do |node|
      node.vm.provision "shell", inline: <<-SHELL
        # Update and upgrade the package list
        sudo apt-get update
        sudo apt-get upgrade -y

        # Install Docker
        sudo apt-get install -y docker.io
        sudo usermod -aG docker vagrant

        # Install k3d
        curl -sfL https://get.k3s.io | sh -s - --flannel-backend none


        # Install kubectl
        sudo curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
        sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
      SHELL
    end
  end
end
