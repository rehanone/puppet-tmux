# View README.md for full documentation
#
# === Authors
#
# Zan Loy <zan.loy@gmail.com>
#
# === Copyright
#
# Copyright 2014
#
class tmux (
  $package          = $tmux::params::package,
  $ensure           = $tmux::params::ensure,
  $auto_update      = $tmux::params::auto_update,
  $conf_file        = $tmux::params::conf_file,
  $prefix_key       = $tmux::params::prefix_key,
  $prefix2_key      = undef,
  $vi_mode_keys     = $tmux::params::vi_mode_keys,
  $pretty_statusbar = $tmux::params::pretty_statusbar,
  $clock            = $tmux::params::clock,
  $default_shell    = $tmux::params::default_shell,
) inherits tmux::params {

  if $ensure == true {
    if $auto_update == true {
      $version = 'latest'
    } else {
      $version = 'present'
    }
  } else {
    $version = 'absent'
  }

  package { $package:
    ensure => $version;
  }

  file { $conf_file:
    ensure => file,
    content => template("${module_name}/tmux.conf.erb");
  }

}
