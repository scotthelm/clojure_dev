class { 'locales':
  default_locale    => 'en_US.UTF-8',
  locales           => ['en_US.UTF-8 UTF-8'],
}
exec {'apt-update':
  command => '/usr/bin/apt-get update',
}

package {'vim':
  ensure => true,
  require => Exec['apt-update'],
}

package {'git':
  ensure => true,
  require => Exec['apt-update'],
}

class { 'postgresql::globals':
  manage_package_repo   => true,
  version               => '9.3',
  encoding              => 'UTF8'
} ->
class { 'postgresql::server':
  require => Class['locales'],
}

postgresql::server::db { 'statsifyme':
  user     => 'statsifyme_login',
  password => postgresql_password(
    'statsifyme_login',
    'I2znNlRWCbWIcuQTmxMUEvfvG5pGljhQ'),
}

postgresql::server::role { 'test_login':
  createdb        => true,
  login           => true,
  password_hash   => postgresql_password(
    'test_login',
    'lOCIePDaNpJt4RKFLOyccBWn7ukBRLHv'),
}
package { 'sqlite3':
  require => Package['libsqlite3-dev']
}
package { 'libsqlite3-dev': }
package { 'libpq-dev': }

file { '/home/vagrant/.vim':
  ensure => 'directory',
  owner  => 'vagrant',
  group  => 'vagrant',
  require => Package['vim'],
}

exec { 'get_vundle':
  command     => 'git clone https://github.com/gmarik/vundle.git /home/vagrant/.vim/bundle/vundle',
  user        => 'vagrant',
  group       => 'vagrant',
  cwd         => '/home/vagrant',
  creates     => '/home/vagrant/.vim/bundle/vundle',
  path        => ['/usr/bin', '/usr/sbin'],
  require     => [
    Package['vim'],
    Package['git'],
    File['/home/vagrant/.vim'],
  ],
}

# exec { 'git_setup_username':
#   command     => 'git config --global user.email "helm.scott@gmail.com"',
#   path        => ['/usr/bin'],
#   require     => Package['git'],
# }
# 
# exec { 'git_setup_name':
#   command     => 'git config --global user.name "Scott Helm"',
#   path        => ['/usr/bin'],
#   require     => Package['git'],
# }

package { 'openjdk-7-jdk': }

exec {'download-leiningen':
  command => '/usr/bin/wget --no-check-certificate -O /home/vagrant/bin/lein https://raw.githubusercontent.com/technomancy/leiningen/f73a9998ff2992ab7574448e5884e08417c21526/bin/lein',
  require => File['/home/vagrant/bin/'],
}

file { '/home/vagrant/bin/lein':
  mode => '755',
  require => Exec['download-leiningen'],
}

file {'/home/vagrant/bin/':
  ensure => 'directory',
  owner => 'vagrant',
  group => 'vagrant',
}
