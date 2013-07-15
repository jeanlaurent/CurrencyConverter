exec { "aptitude update":
  path => "/usr/bin",
}
package {"openjdk-7-jdk":
  ensure  => present,
  require => Exec["aptitude update"],
}
package { "tomcat7":
  ensure  => present,
  require => Package["openjdk-7-jdk"],
}
service { "tomcat7":
  ensure  => running,
  require => Package["tomcat7"],
}
