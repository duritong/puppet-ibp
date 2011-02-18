class ibp::sysrq::linux {
  sysctl::set_value{'kernel.sysrq': value => '1' 
}
