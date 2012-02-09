class ibp::panics::linux {
  exec{"grub_panics": }
  # grub 2.0 systems
  if ($::operatingsystem == 'Debian') and ($::lsbdistcodename != 'lenny') {
    Exec["grub_panics"]{
      command => "sed -i 's@^\\(GRUB_CMDLINE_LINUX=\".*\\)\"@\\1 panic=30\"@g' /etc/default/grub",
      unless => "grep -qE '^GRUB_CMDLINE_LINUX=.*panic=30.*' /etc/default/grub",
      notify => Exec['update_grub_2.0'],
    }
    exec{'update_grub_2.0':
      command => 'update-grub',
      refreshonly => true,
    }
  } else {
    $grubmenu_location = $::operatingsystem ? {
      debian => "/boot/grub/menu.lst",
      ubuntu => "/boot/grub/menu.lst",
      default => "/boot/grub/grub.conf"
    }
    Exec["grub_panics"]{
      command => "sed -i 's@\\(.*vmlinuz.*\\)@\\1 panic=30@g' ${grubmenu_location}",
      unless => "grep -q 'panic=30' ${grubmenu_location}",
    }
  }

  sysctl::value{
    # set the reboot time for kernel panics
    'kernel.panic':
        value => '30';
  }
  # these values aren't yet present on a debian lenny
  if !(($::operatingsystem == 'Debian') and ($::lsbdistcodename == 'lenny')) {
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
