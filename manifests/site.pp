file { '/var/test.puppet':
ensure => 'present',
mode => 777,
}


class {'bind9': }
