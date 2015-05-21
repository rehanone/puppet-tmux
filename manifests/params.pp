# Manifest for default values for tmux
class tmux::params {

  # OS Specific Values
  case $::osfamily {
    'ArchLinux': { }
    'Debian': { }
    'RedHat': { }
    default: {
      fail("tmux module does not currently support osfamily = ${::osfamily}")
    }
  }

  $package          = 'tmux'
  $ensure           = true
  $auto_update      = false
  $conf_file        = '/etc/tmux.conf'
  $prefix_key       = 'default'
  $vi_mode_keys     = true
  $pretty_statusbar = true
  $clock            = true
  $default_shell    = undef
}
