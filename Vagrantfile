Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  config.vm.synced_folder "apps", "/var/apps"
  config.ssh.private_key_path = "~/.ssh/id_rsa"
  config.ssh.forward_agent = true

  config.vm.define "clojure_dev" do |vm|
    vm.vm.hostname = "clojure-dev"
    vm.vm.network :private_network, ip: "33.33.13.15"

    vm.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--name", "clojure_dev", "--memory", "2048", "--rtcuseutc", "on"]
      v.gui = false
    end
  end
  config.vm.provision "puppet" do |puppet|
    puppet.manifest_file = "default.pp"
    puppet.module_path = "modules"
    puppet.manifests_path = "manifests"
  end
end
