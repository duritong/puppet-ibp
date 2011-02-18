class ibp::sysrq::linux {
  sysctl::value{'kernel.sysrq': value => '1' } 
}
