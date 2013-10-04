Vagrant.configure("2") do |config|
  
  config.vm.define :factory do |factory_config|
      factory_config.vm.box = "factory"
      factory_config.vm.box_url = "http://files.vagrantup.com/precise32.box"
      factory_config.vm.hostname = "factory"
      factory_config.vm.network :private_network, ip: "10.10.10.10"
      factory_config.vm.network :forwarded_port, guest:80, host:8080, autocorrect:true
      factory_config.vm.network :forwarded_port, guest:81, host:9000, autocorrect:true
      factory_config.vm.network :forwarded_port, guest:82, host:4516, autocorrect:true
  end

  config.vm.define :target do |target_config|
      target_config.vm.box = "target"
      target_config.vm.box_url = "http://files.vagrantup.com/precise32.box"
      target_config.vm.hostname = "target"
      target_config.vm.network :private_network, ip: "10.10.10.11"
      target_config.vm.network :forwarded_port, guest:80, host:8080, autocorrect:true
      target_config.vm.provision :puppet do |puppet_config|
        puppet_config.manifest.file = 'deployit.pp'
        puppet_config.module_path = 'manifests/modules'
      end
  end

end