Vagrant.configure("2") do |config|
    config.vm.box = "centos/7"

    config.vm.network "forwarded_port", guest: 80, host: 8080

    $puppet_install = "
	if [[ ! -d /vagrant/files/ ]]
	then
	  this=`sudo find / -name 'puppetlabs-release-el-7.noarch.rpm'`
	  sudo rpm -ih $this
	  sudo ln -s `echo $this | sed -e 's/files\/puppet*//'` /vagrant/
	else
	  sudo rpm -ih /vagrant/files/puppetlabs-release-el-7.noarch.rpm
	  sudo rpm -Uh https://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
	fi
	if [[ ! -d /vagrant/puppet/ ]]
	then
	    sudo mkdir /vagrant/
	    sudo yum install -y git
	    sudo git clone https://github.com/vayw/askbotdeploy/ /vagrant/
	fi
        sudo yum -y install puppet
    "

    config.vm.provision "shell", inline:$puppet_install

    config.vm.provision :puppet do |puppet|
        puppet.manifests_path = ["vm", "/vagrant/puppet/"] 
        puppet.manifest_file  = "manifests"
    end

    config.vm.provision "ansible" do |ansible|
        ansible.playbook = "emptyplaybook.yml"
    end
end
