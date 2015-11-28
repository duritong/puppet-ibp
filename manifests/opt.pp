# manage /opt
class ibp::opt {
  file{'/opt':
    ensure => directory,
    owner  => root,
    group  => 0,
    mode   => '0755';
  }
}
