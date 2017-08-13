package {'epel-release':
    ensure => installed,
}

package {'python34':
    ensure => installed,
    require => Package['epel-release'],
}

file { 'environment':
    path => "/etc/environment",
    source => "/vagrant/puppet/files/environment",
}

file { 'factdir_p':
    path => "/etc/facter/",
    ensure => "directory",
    owner => "root",
    group => "root",
}

file { 'factdir':
    path => "/etc/facter/facts.d/",
    ensure => "directory",
    owner => "root",
    group => "root",
    require => File['factdir_p'],
}

file { 'custom_hypervisor_fact':
    path => "/etc/facter/facts.d/hypervisor.rb",
    source => "/vagrant/puppet/facter/hypervisor.rb",
    owner => "root",
    group => "root",
    require => File['factdir'],
}
