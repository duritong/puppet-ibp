class ibp::network {
  case $::operatingsystem {
      redhat,centos: { include ibp::network::disablezeroconf }
   }
}
