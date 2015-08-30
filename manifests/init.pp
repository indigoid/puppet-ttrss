class ttrss {
  class { 'ttrss::webserver':
    vhost => "tt.${::domain}",
  }
  include ttrss::database
}
