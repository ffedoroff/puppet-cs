# remove ALL unmanaged host resources
resources { 'host':
	purge => true
 }

host { $hostname:
  ensure => 'present',
  ip     => '127.0.1.1',
  target => '/etc/hosts',
  host_aliases => ['localhost', 'local'],
}

host { 'cybersponse.local':
  ensure => 'present',
  ip     => '127.0.0.1',
  target => '/etc/hosts',
  host_aliases => ['ext.cybersponse.local2', 'comet.cybersponse.local'],
}

if $hostname != 'roman-desktop2' {
  host { 'roman-desktop2':
    ensure => 'present',
    ip     => '192.168.0.102',
    target => '/etc/hosts',
  }
}