VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "ubuntu/trusty64"

    config.vm.box_url = "https://atlas.hashicorp.com/ubuntu/boxes/trusty64"

    config.vm.network :forwarded_port, guest: 105, host: 8095

    config.vm.network :private_network, :ip => "10.0.1.105"

    config.vm.provision :shell, :path => "installer.sh"

    config.vm.synced_folder ".", "/vagrant", :owner => 'www-data', :group => 'www-data', :mount_options => ["dmode=777", "fmode=777"]

    config.ssh.forward_agent = true

    config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", "2048"]
    end
end
