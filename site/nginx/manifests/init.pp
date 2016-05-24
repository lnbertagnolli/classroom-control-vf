class nginx {
  package { 'nginx':
    ensure => present,
  }
  
  file { 'docroot':
    path => '/var/www',
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '0644',
    require => Package['nginx'],
  }
  
  file { 'index':,
    path => '/var/www/index.html',
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    require => File['docroot'],
    source => 'nginx/index.html',
  }
  
  file { 'nginxconfigdir':
    path => '/etc/nginx',
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '0644',
    require => Package['nginx'],
  }
  
  file { 'nginxconfig':,
    path => '/etc/nginx/nginx.conf',
    ensure => file,
    owner = 'root',
    group => 'root',
    mode => '0644',
    require => File['nginxconfigdir':,
    source => 'puppet:///nginx/nginx.conf',
  }
  
  file { 'nginxdefaultdir':
    path => '/etc/nginx/conf.d',
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '0644',
    require => Package['nginx'],
  }
  
  file { 'nginxdefaultconf':
    path => '/etc/nginx/conf.d/default.conf',
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    require => File['nginxdefaultdir'],
    source => 'puppet:///nginx/default.conf',
  }
  
  service { 'nginx':
    ensure => running,
    require => Package['nginx'],
    subscript => File['nginxdefaultyconf', 'nginxconfig', 'index']
  }
  
