# manifests/init.pp

class ibp {
  include ibp::network
  include ibp::panics

  case $::virtual {
    physical,xen0: {
      include ibp::setterm
      include ibp::sysrq
    }
  }
}
