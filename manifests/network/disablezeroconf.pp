class ibp::network::disablezeroconf {
  line{'disable_zeroconf':
    line => 'NOZEROCONF=yes',
    file => '/etc/sysconfig/network',
  }
}

