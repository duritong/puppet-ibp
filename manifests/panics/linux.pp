# optimizations that we do on our linux installations
class ibp::panics::linux(
  $use_grub = true
) {

  if $use_grub and ($::lsbdistid != 'Raspbian') {
    exec{'grub_panics': }
    # grub 2.0 systems
    if ($::operatingsystem == 'Centos') and ($::operatingsystemmajrelease < 7) {
      Exec['grub_panics']{
        command => 'sed -i \'s@\(.*vmlinuz.*\)@\1 panic=30@g\' /boot/grub/grub.conf',
        unless  => 'grep -q \'panic=30\' /boot/grub/grub.conf'
      }
    } else {
      Exec['grub_panics']{
        command => "sed -i 's@^\\(GRUB_CMDLINE_LINUX=\".*\\)\"@\\1 panic=30\"@g' /etc/default/grub",
        unless  => 'grep -qE \'^GRUB_CMDLINE_LINUX=.*panic=30.*\' /etc/default/grub',
        notify  => Exec['update_grub_2.0'],
      }

      if ($::operatingsystem == 'Centos') and ($::operatingsystemmajrelease > 6) {
        $grub_update_cmd = 'grub2-mkconfig -o /boot/grub2/grub.cfg'
      } else {
        $grub_update_cmd = 'update-grub'
      }
      exec{'update_grub_2.0':
        command     => $grub_update_cmd,
        refreshonly => true,
      }
    }
  }

  sysctl::value{
    # set the reboot time for kernel panics
    'kernel.panic':
      value => '30';
  }
  if !($::operatingsystem == 'Centos' and $::operatingsystemmajrelease > 6) {
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
