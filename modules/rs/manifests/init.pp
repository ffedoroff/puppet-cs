define rs::tools {
  $tools = [ 'sudo', 'mc', 'nano', 'htop', 'dnsutils', 'cron', 'wget' ]
  package { $tools: ensure => "installed" }
}

define rs::cs::developer (
  $tools = true,
  $external = true,
  $longpooling = false,
  $ssl = true,
  $webserver = 'apache',
  $csurl = 'cybersponse.local',
  $sethosts = true
) {
	
	if $tools == true {
		rs::tools {$hostname: }
    }

	$cs = [ 'git', 'postgresql', 'php5', 'php-pear', 'phpunit' ]
	package { $cs: ensure => "installed" }

	postgres::hba { "local":
      allowedrules => [
        "local    all all      md5",
      ],
    }
	
	/*postgres::createuser{"userr":passwd => "pass",}
	postgres::createdb{"db_dev":owner=> "userr",}
	postgres::createdb{"db_test":owner=> "userr",}
	postgres::createdb{"db_external_dev":owner=> "userr",}
*/
	if $webserver == 'apache' {
		class {'apache':  }
		class {'apache::mod::php': }
		apache::vhost { $csurl:
		  priority        => '51',
		  vhost_name      => $csurl,
		  port            => '80',
		  docroot         => '/var/www/',
		  serveraliases   => [$csurl,'ext.cybersponse.local'],
		}
		php::module { ['ldap']: # openssl, fileinfo
			notify  => Service[$apache::params::apache_name],
		}
	}

	if $sethosts == true {
		host { $csurl:
			ensure => 'present',
			ip     => '127.0.0.1',
			target => '/etc/hosts',
			host_aliases => ["ext.$csurl", "comet.$csurl"],
		}
	}



  	notify {"ext:$external lp:$longpooling ssl:$ssl ws:$webserver":}
}


/*
file { "/tmp/facts.yaml":
    content => inline_template("<%= scope.to_hash.reject { |k,v| !( k.is_a?(String) && v.is_a?(String) ) }.to_yaml %>"),
}
*/