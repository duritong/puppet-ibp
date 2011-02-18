class ibp::setterm::linux {
  require ibp::rclocal
  line{'turn_screen_blanking_off':
    file => '/etc/rc.local',
    line => "/usr/bin/setterm -blank 0",
  }
}
