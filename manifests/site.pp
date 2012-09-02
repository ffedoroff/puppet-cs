
# include pear

node default {
  $tools = [ 'sudo', 'mc', 'nano', 'htop', 'dnsutils', 'cron', 'wget' ]
  package { $tools: ensure => "installed" }
#}

# node roman-desktop 

#node default {

  $cs = [ 'git', 'postgresql', 'php5', 'php-pear', 'phpunit' ]
  package { $cs: ensure => "installed" }

  #pear::package { "PEAR": }
  #pear::package { "PHPUnit": ensure => "installed"}

  class {'apache':  }
  class {'apache::mod::php': }
  apache::vhost { 'cybersponse.local':
      priority        => '10',
      vhost_name      => 'cybersponse.local',
      port            => '80',
      docroot         => '/var/www/',
      serveraliases   => ['cybersponse.local','ext.cybersponse.local'],
  }

  host { 'cybersponse.local':
    ensure => 'present',
    ip     => '127.0.0.1',
    target => '/etc/hosts',
    host_aliases => ['ext.cybersponse.local', 'comet.cybersponse.local'],
  }

  php::module { [ 'ldap']: # openssl, fileinfo
    notify  => Service[$apache::params::apache_name],
  }

}



/*
file { '/var/test.puppet':
ensure => 'present',
mode => 777,
}

  php::module { [ 'ldap', 'openssl', 'fileinfo' ]:
    require => Apt::Sources_list['dotdeb-php53'],
    notify  => Service['apache'],
  }


class {'bind9': }

file { "/tmp/facts.yaml":
    content => inline_template("<%= scope.to_hash.reject { |k,v| !( k.is_a?(String) && v.is_a?(String) ) }.to_yaml %>"),
}


*/