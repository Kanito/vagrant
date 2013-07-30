package { "mysql-server": ensure => installed }

exec { "Set MySQL server root password":
	require => Package["mysql-server"],
	path => "/bin:/usr/bin",
	command => "mysqladmin -u root -p'' password 'password2'",
}

exec { "create-HiCollege-db":
	unless => "/usr/bin/mysql -uroot -ppassword2 HiCollege",
	command => "/usr/bin/mysql -uroot -ppassword2 -e \"create database HiCollege;\"",
	require => Exec["Set MySQL server root password"],
}
