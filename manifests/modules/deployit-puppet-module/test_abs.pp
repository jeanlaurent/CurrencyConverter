deployit { "remote":
	username => "admin",
	password => "admin",
	url => "http://192.168.34.181:4516",
}


container { "Infrastructure/host2":
    type     => "overthere.SshHost",
    ensure   => absent,
    values   => { os => UNIX, address => $ipaddress, username  => scott, password => tiger},
    server   => Deployit["remote"],
}

container { "Infrastructure/host2/apache":
    type     => "www.ApacheHttpdServer",
    tags     => ['frontend', 'www'],
    ensure   => absent,
    values   => { startCommand => "start.sh" , stopCommand => "stop.sh", defaultDocumentRoot => '/opt/doc', configurationFragmentDirectory => '/opt/conf' },
    require => [Container['Infrastructure/host2'] ],
    server   => Deployit["remote"],
}
container { "Infrastructure/host2/tomcat":
    type     => "tomcat.Server",
    tags     => ['frontend', 'www'],
    ensure   => absent,
    values   => { startCommand => "start.sh" , stopCommand => "stop.sh", home => '/opt/tomcat6', startWaitTime => 10, stopWaitTime => 22 },
    require => Container['Infrastructure/host2'] ,
    server   => Deployit["remote"],
}

container { "Infrastructure/host2/tomcat/tomcat.vh" :
    type     => "tomcat.VirtualHost",
    require => Container['Infrastructure/host2/tomcat'],
    server   => Deployit["remote"],
    values   => { },
    ensure   => absent,
}
