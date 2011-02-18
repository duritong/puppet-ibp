class ibp::rclocal::debian {
  line{'remove_exit_0_from_rc_local_to_enabe_it':
    line => 'exit 0',
    file => '/etc/rc.local',
    ensure => 'absent',
  }
}
