package {'nginx':
    ensure => installed,
    require => Package['epel-release'],
    }

service { 'nginx':
    ensure => running,
    enable => true,
    hasrestart => true,
    require => [
        Package['nginx'],
    ],
 }
