# manifests/opt/bin.pp

class ibp::opt::bin inherits ibp::opt {

    file{'/opt/bin':
        ensure => directory,
        owner => root, group => 0, mode => 0755;
    }

}
