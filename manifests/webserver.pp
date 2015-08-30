define ttrss::webserver::php (
  $vhost,
  $www_root    = '/var/www',
  $backend     = "127.0.0.1:9000",
  $listen_port = 80,
  $index_files = ['index.php', 'index.html', 'index.htm'],
) {
  nginx::resource::vhost { $vhost:
    ensure      => present,
    listen_port => $listen_port,
    www_root    => $www_root,
  }
  nginx::resource::location { "${vhost}_root":
    ensure          => present,
    vhost           => $vhost,
    www_root        => $www_root,
    location        => '~ \.php$',
    index_files     => $index_files,
    proxy           => undef,
    fastcgi         => $backend,
    fastcgi_script  => undef,
      location_cfg_append => {
       fastcgi_connect_timeout => '3m',
       fastcgi_read_timeout    => '3m',
       fastcgi_send_timeout    => '3m'
    }
  }
}

class ttrss::webserver (
  $vhost,
  $docroot = '/opt/tt',
  $port    = 80,
) {
  include ::php
  include ::nginx
  ::ttrss::webserver::php { $vhost:
    vhost       => $vhost,
    www_root    => $docroot,
    listen_port => $port,
  }
}
