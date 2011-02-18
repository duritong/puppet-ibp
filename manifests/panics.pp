class ibp::panics {
  case $kernel {
    linux: { include ibp::panics::linux }
  }
}
