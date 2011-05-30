class ibp::panics::linux {

  $grubmenu_location = $operatingsystem ? {
    debian => "/boot/grub/menu.lst",
    ubuntu => "/boot/grub/menu.lst",
    default => "/boot/grub/grub.conf"
  }

  exec{"grub_panics":
    command => "sed -i 's@\\(.*vmlinuz.*\\)@\\1 panic=30@g' ${grubmenu_location}",
    unless => "grep -q 'panic=30' ${grubmenu_location}",
  }

  sysctl::value{
    # set the reboot time for kernel panics
    'kernel.panic':
        value => '30';
  }
  # these values aren't yet present on a debian lenny
  if ($operatingsystem != 'Debian') or (lsbdistcodename != 'lenny') {
	  sysctl::value{
	    # Panic if a hung task was found
	    'kernel.hung_task_panic':
	        value => 1;
	    # Setup timeout for hung task to 300 seconds
	    'kernel.hung_task_timeout_secs':
	        value => 300;
	  }
  }
}
