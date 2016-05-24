class memcached {
  package { 'memcached':
    ensure => '1.4.15-9.e17',
#    ensure => present,
  }
  file { '/etc/syconfig/memcached':
    ensure => file,
    require => Package['memcached'],
    source => 'puppet:///modules/memcached/config',
    owner => 'root',
    group => 'root',
    mode => '0644',
  }
  service { 'memcached':
    ensure => running,
    enable => true,
    subscribe => File['/etc/sysconfig/memcached'],
  }
}
