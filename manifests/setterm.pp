class ibp::setterm {
  case $kernel {
    linux: { include ibp::setterm::linux }
  }
}

