class ttrss::webserver {
  require ::apache
  require ::php
  ::php::apache::vhost { 'tt':
    vhost         => "tt.${::domain}",
    serveraliases => [ $::fqdn ],
  }
}
