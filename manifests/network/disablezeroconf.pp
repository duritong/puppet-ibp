class ibp::network::disablezeroconf {
  exec{disable_zeroconf:
    command => 'echo "NOZEROCONF=yes" >> /etc/sysconfig/network',
    unless => 'grep -q "NOZEROCONF" /etc/sysconfig/network',
  }
}

