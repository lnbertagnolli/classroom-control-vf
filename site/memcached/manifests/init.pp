class memcached {
  package { 'memcached':
    ensure => present,
  }
  file { 'memcachedconfig':
    path => '/etc/syconfig/memcached',
    ensure => file,
    require => Package['memcached'],
    source => 'puppet:///modules/memcached/config',
    user => 'root',
    group => 'root',
    mode => '0644',
  }
  service { 'memcached':
    ensure => running,
    enable => true,
    subscribe => File['memcachedconfig'],
  }
}
