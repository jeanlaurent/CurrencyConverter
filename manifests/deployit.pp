deployit { "deployit":
	username => "admin",
	password => "admin",
	url => "http://10.11.12.13:4516",
}

# host declaration
container { "Infrastructure/host.vm":
    type     => "overthere.SshHost",
    ensure   => present,
    values   => { os => UNIX, address => $ipaddress, username  => vagrant, password => vagrant},
    server   => Deployit["deployit"],
}

# tomcat declaration
container { "Infrastructure/host.vm/tomcat":
    type     => "tomcat.Server",
    tags     => ['frontend', 'www'],
    ensure   => present,
    values   => { startCommand => "/usr/sbin/service tomcat7 start" , stopCommand => "/usr/sbin/service tomcat7 stop", home => '/usr/share/tomcat7', startWaitTime => 10, stopWaitTime => 22 },
    require => Container['Infrastructure/host.vm'] ,
    server   => Deployit["deployit"],
}

#vh declaration
container { "Infrastructure/host.vm/tomcat/tomcat.vh" :
    type     => "tomcat.VirtualHost",
    require => Container['Infrastructure/host.vm/tomcat'],
    server   => Deployit["deployit"],
    values   => { },
    ensure   => present,
}
