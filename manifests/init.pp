# manifests/init.pp

class ibp {
    include ibp::opt
    include ibp::opt::bin
}
