class ibp::rclocal::debian {
  file_line{'remove_exit_0_from_rc_local_to_enabe_it':
    line => 'exit 0',
    path => '/etc/rc.local',
    ensure => 'absent',
  }
}
