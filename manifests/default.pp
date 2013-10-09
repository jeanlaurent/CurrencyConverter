$user = "***internet-username***"
$pass = "***internet-password***"
$proxy = "http://${user}:${pass}@proxy.fr.world.socgen:8080/"
file { "/etc/environment":
  content => "HTTP_PROXY=${proxy}
              HTTPS_PROXY=${proxy}
              NO_PROXY=localhost,127.0.0.1"
}
$aptconf = 'Acquire { Retries "0"; HTTP { Proxy "$proxy"; }; };
            Acquire { Retries "0"; HTTPS { Proxy "$proxy"; }; };'
notify { "$aptconf": }
#file { "/etc/apt/apt.conf"
#  content => "$aptconf";
#}
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
