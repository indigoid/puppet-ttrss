class ttrss::webserver (
  $vhost,
  $docroot = '/opt/tt',
  $port    = 80,
) {
  require ::apache
  require ::apache::mod::fastcgi
  require ::php
  ::php::apache_vhost { 'tt':
    vhost         => "tt.${::domain}",
    serveraliases => [ $::fqdn ],
  }
  ::apache::fastcgi::server { 'php':
    host       => '127.0.0.1:9000',
    timeout    => 15,
    flush      => false,
    faux_path  => '/var/www/php.fcgi',
    fcgi_alias => '/php.fcgi',
    file_type  => 'application/x-httpd-php',
  }
  ::apache::vhost { $vhost:
    docroot         => $docroot,
    default_vhost   => $vhost,
    port            => $port,
    override        => 'all',
    custom_fragment => 'AddType application/x-httpd-php .php',
    require         => Apache::Fastcgi::Server['php'],
  }
}
