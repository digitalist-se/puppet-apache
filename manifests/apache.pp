class apache (
  # Some useful modules.
  $modules = [
    'rewrite'
  ],
  # A set of common configuration files. These files can be replaced
  # by removing them from this array.
  $conf_files = [
    'apache2.conf',
    'conf.d/charset',
    'conf.d/default',
    'conf.d/log',
    'conf.d/security',
    'conf.d/ssl',
    'conf.d/tweaks',
    'httpd.conf',
    'ports.conf'
  ]
) {

  package { 'apache2':
    ensure => installed,
  }

  package { 'apache2-mpm-prefork':
    ensure => installed,
    require => Package['apache2'],
  }

  service { apache2:
    enable  => true,
    ensure  => running,
    require => Package['apache2'],
  }

  apache::conf_file { $conf_files:
    require => Package['apache2'],
  }

  apache::module { $modules:
    require => Package['apache2'],
  }
  Package { require => Exec['apt-get update'] }
}
