exec { "apt-get update": 
	command => "/usr/bin/apt-get update",
}

package { "openjdk-7-jdk":
	ensure => installed,
	require => Exec["apt-get update"],
}

package { "maven":
        ensure => installed,
        require => Package["openjdk-7-jdk"],
}

package { "git":
        ensure => installed,
        require => Package["maven"],
}
