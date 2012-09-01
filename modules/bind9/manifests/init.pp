
class bind9 {
  package { "bind9":
      ensure => installed
  }

  package { "dnsutils":
      ensure => installed
  }
 
  service { "bind9":
    enable => true,
    ensure => running,
    hasrestart => true,
    subscribe => [ Package["bind9"] ],
  }
 
  file {
    "/etc/bind/named.conf.local":
      mode => 644,
      owner => root,
      group => root,
      source => "puppet:///modules/bind9/private/named.conf.local"
  }

  file {
    "/etc/bind/db.example.com":
      mode => 644,
      owner => root,
      group => root,
      source => "puppet:///modules/bind9/private/db.example.com"
  }
}
