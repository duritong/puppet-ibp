class ibp::network::disablezeroconf {
  file_line{'disable_zeroconf':
    line => 'NOZEROCONF=yes',
    path => '/etc/sysconfig/network',
  }
}

