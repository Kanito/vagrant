Vagrant.configure("2") do |config|
	config.vm.box = "precise64"
	config.vm.box_url = "http://files.vagrantup.com/precise64.box"
	config.vm.provider "virtualbox" do |v|
		#v.gui = true
		v.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
		v.customize ["modifyvm", :id, "--memory", "1024"]
	end
	config.vm.network :forwarded_port, guest: 80, host: 8080
	config.vm.network :forwarded_port, guest: 4444, host: 4444
	config.vm.network :forwarded_port, guest: 8181, host: 8181
	
	config.vm.provision :puppet do |puppet|
		puppet.options = "--verbose --debug"
		puppet.manifests_path = "manifests"
		puppet.manifest_file = "default.pp"
	end
	config.vm.provision :shell, :path => "jenkins.sh"
	config.vm.provision :shell, :path => "apache.sh"	
	config.vm.provision :shell, :path => "git.sh"
	config.vm.provision :puppet do |puppet|
		puppet.options = "--verbose --debug"
		puppet.manifests_path = "manifests"
		puppet.manifest_file = "mysql-server.pp"
	end
	config.vm.provision :shell, :path => "glassfish.sh"
	config.vm.provision :shell, :path => "jenkins2.sh"
end
