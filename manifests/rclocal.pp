class ibp::rclocal {
  case $operatingsystem {
    debian,ubuntu: { include ibp::rclocal::debian }
  }
}
