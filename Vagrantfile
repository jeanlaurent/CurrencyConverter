# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|

  config.vm.define :precise64 do |precise64|
    	precise64.vm.box = "precise64"
    	precise64.vm.network :hostonly,"10.11.12.13"
    	# precise64.vm.network :bridged
    	precise64.vm.forward_port 80, 8080
  end

  config.vm.provision :puppet

end