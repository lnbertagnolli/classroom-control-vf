class skeleton {
  file { '/etc/skel':
    ensure => directory,
  }
  file { '/etc/skel/.bashrc':
    ensure => present,
    owner => 'root',
    group => 'root',
    mode => '0644',
    source => 'puppet:///modules/skeleton/bashrc',
  }
}
