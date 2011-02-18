class ibp::panics::linux {

  $grubmenu_location = $operatingsystem ? {
    debian => "/boot/grub/menu.lst",
    ubuntu => "/boot/grub/menu.lst",
    default => "/boot/grub/grub.conf"
  }

  exec{"grub_panics":
    command => "sed -i 's@\(.*vmlinuz.*\)@\1 panic=30@g' ${grubmenu_location}",
    unless => "grep -q 'panic=30' ${grubmenu_location}",
  }

  # set the reboot time for kernel panics
  sysctl::set_value{'kernel.panic': value => '30' }
}
