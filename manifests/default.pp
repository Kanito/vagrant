exec { "apt-get update": 
	command => "/usr/bin/apt-get update",
}

package { "openjdk-7-jdk":
	ensure => installed, #7u25-2.3.10-1ubuntu0.12.04.2
	require => Exec["apt-get update"],
}

package { "maven":
        ensure => "3.0.4-2",
        require => Package["openjdk-7-jdk"],
}

package { "git":
        ensure => "1:1.7.9.5-1",
        require => Package["maven"],
}
