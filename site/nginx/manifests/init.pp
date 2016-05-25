class nginx {
   package { ['openssl', openssl-libs
     ensure => ;1.0.1e-51.el7_2.5',
     before => Package['nginx'],
   }
   
   file { 'nginx rpm' :
    ensure   => file,
    path     => '/opt/nginx-1.6.2-1.el7.centos.ngx.x86_64.rpm',
    source   => 'puppet:///modules/nginx/nginx-1.6.2-1.el7.centos.ngx.x86_64.rpm',
  }

  package { 'nginx' :
    ensure   => '1.6.2-1.el7.centos.ngx',
    source   => '/opt/nginx-1.6.2-1.el7.centos.ngx.x86_64.rpm',
    provider => rpm,
    require  => File['nginx rpm'],
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
    source => 'puppet:///modules/nginx/index.html',
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
    path    => '/etc/nginx/nginx.conf',
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => File['nginxconfigdir'],
    source  => 'puppet:///modules/nginx/nginx.conf',
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
    source => 'puppet:///modules/nginx/default.conf',
  }
  
  service { 'nginx':
    ensure => running,
    require => Package['nginx'],
    subscribe => File['nginxdefaultconf', 'nginxconfig', 'index']
  }
}  
