Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/jammy64"

    # config.vm.provider :virtualbox do |vb|
    #   vb.gui = true
    # end

    config.vm.provision "shell", path: "scripts_vagrant/install_terraform.sh"

    # require plugin https://github.com/leighmcculloch/vagrant-docker-compose
    config.vagrant.plugins = "vagrant-docker-compose"

    # install docker and docker-compose
    config.vm.provision :docker
    config.vm.provision :docker_compose

    config.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--ioapic", "on"]
      vb.customize ["modifyvm", :id, "--memory", "2048"]
      vb.customize ["modifyvm", :id, "--cpus", "2"]
    end

    config.vm.provision "file", source: "Dockerfile", destination: "/home/vagrant/Dockerfile"
    config.vm.provision "shell", path: "scripts_vagrant/copy_app.sh"
    config.vm.provision "shell", path: "scripts_vagrant/nodejs_app_test.sh"

    # config.vm.network "forwarded_port", guest: 3000, host: 3000
    config.vm.network "forwarded_port", guest: 18000, host: 18000

    config.vm.provision "shell", inline: "apt-get install --assume-yes python3-pip"
    config.vm.provision "shell", path: "scripts_vagrant/install_aws_cli.sh", privileged: false
    config.vm.provision "shell", path: "scripts_vagrant/setup_acces_keys.sh", privileged: false
    config.vm.provision "shell", inline: "chown vagrant:vagrant /home/vagrant/.aws/credentials"
  end
