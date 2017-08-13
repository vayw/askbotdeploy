package {'mariadb-server':
    ensure => installed,
}
package {'mariadb-libs':
    ensure => installed,
}

service { 'mariadb':
    ensure => running,
    enable => true,
    hasrestart => true,
    require => [
        Package['mariadb-server'],
    ],
 }

