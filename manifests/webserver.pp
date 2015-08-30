class ttrss::webserver {
  require ::apache
  require ::php
  ::php::apache_vhost { 'tt':
    vhost         => "tt.${::domain}",
    serveraliases => [ $::fqdn ],
  }
}
