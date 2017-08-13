package {'epel-release':
    ensure => installed,
  }

package {'python34':
    ensure => installed,
    require => Package['epel-release'],
  }
