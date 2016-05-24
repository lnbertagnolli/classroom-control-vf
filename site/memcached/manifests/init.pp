class memcached {
  package { 'memcached':
    ensure => present,
  }
  file { 'memcachedconfig':
    name => '/etc/syconfig/memcached',
    ensure => present,
    require => Package['memcached'],
  }
}
