define apache::conf_file() {
  file { "/etc/apache2/${name}":
    owner  => root,
    group  => root,
    mode   => 0444,
    source => "puppet:///modules/apache/${name}",
  }
}

define apache::module() {
  exec { "a2enmod ${name}":
    command => "/usr/sbin/a2enmod ${name}",
    notify => Service['apache2'],
    require => Package['apache2'],
  }
} 
