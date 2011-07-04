class apache (
  $module_root = '/tmp/vagrant-puppet/manifests/modules/apache',
  $packages = [
    'apache2'
  ],
  $modules = [
    'rewrite'
  ],
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
  package { $packages:
    ensure => installed,
  }

  service { apache2:
    enable  => true,
    ensure  => running,
    require => Package['apache2'],
  }

  conf_file { $conf_files:
    require => Package['apache2'],
  }

  module { $modules:
    require => Package['apache2'],
  }

  define conf_file() {
    file { "/etc/apache2/${name}":
      owner  => root,
      group  => root,
      mode   => 0444,
      source => "${module_root}/files/${name}",
    }
  }

  define module() {
    exec { "a2enmod ${name}":
      command => "/usr/sbin/a2enmod ${name}",
      notify => Service['apache2'],
    }
  } 
}
