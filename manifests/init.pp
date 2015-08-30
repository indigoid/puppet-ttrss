class ttrss {
  class { 'ttrss::webserver':
    vhost => "tt.${::fqdn}",
  }
  include ttrss::database
}
