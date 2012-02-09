# manifests/init.pp

class ibp {
  include ibp::opt
  include ibp::opt::bin

  include ibp::network
  include ibp::panics

  case $::virtual {
    physical,xen0: {
      include ibp::setterm
      include ibp::sysrq
    }
  }
}
