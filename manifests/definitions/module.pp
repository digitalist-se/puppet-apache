define apache::module() {
  exec { "a2enmod ${name}":
    command => "/usr/sbin/a2enmod ${name}",
    notify => Service['apache2'],
    require => Package['apache2'],
    unless => "test -e /etc/apache2/mods-enabled/${name}.conf"
  }
}
