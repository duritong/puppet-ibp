class ibp::sysrq {
  case $::kernel {
    linux: { include ibp::sysrq::linux }
  }
}

