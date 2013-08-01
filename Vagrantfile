Vagrant::Config.run do |config|
	config.vm.box = "precise64"
	config.vm.box_url = "http://files.vagrantup.com/precise64.box"
	config.vm.forward_port 80, 8080
	config.vm.provision "puppet"
	config.vm.provision "shell", path:"jenkins.sh"
	config.vm.provision "shell", path:"apache.sh"
	config.vm.provision "shell", path:"git.sh"
	config.vm.provision :puppet do |puppet|
   		puppet.manifests_path = "manifests"
		puppet.manifest_file = "mysql-server.pp"
	end
	config.vm.provision "shell", path:"glassfish.sh"
	config.vm.provision "shell", path:"jenkins2.sh"
end
