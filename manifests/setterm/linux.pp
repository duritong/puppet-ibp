class ibp::setterm::linux {
  require ibp::rclocal
  file_line{'turn_screen_blanking_off':
    path => '/etc/rc.local',
    line => "/usr/bin/setterm -blank 0",
  }
}
