# == Class: tmux
#
# This is a puppet class to manage installation and configuration of tmux.
#
# === Parameters
#
# [ensure]
#   Whether to ensure the tmux package is installed or absent.
#
# [auto_update]
#   Whether the tmux package should upgrade itself based on the system
#   package manager.
#
# [conf_file]
#   The absolute path to the tmux configuration file.
#
# [prefix_key]
#   The prefix key used by tmux to access tmux commands and control.
#
# [vi_mode_keys]
#   Whether to use vi style keys during history buffer scrolling etc.
#
# [pretty_statusbar]
#   Whether to use a pretty statusbar in your tmux session.
#
# [clock]
#   Whether to include a clock in the status bar. (Set to false to prevent
#   terminal from showing updates every minute when clock updates)
#
# === Examples
#
#   See README.md
#
# === Authors
#
# Zan Loy <zan.loy@gmail.com>
#
# === Copyright
#
# Copyright 2014 Zan Loy
#
class tmux (
  $ensure           = $tmux::params::ensure,
  $auto_update      = $tmux::params::auto_update,
  $conf_file        = $tmux::params::conf_file,
  $prefix_key       = $tmux::params::prefix_key,
  $vi_mode_keys     = $tmux::params::vi_mode_keys,
  $pretty_statusbar = $tmux::params::pretty_statusbar,
  $clock            = $tmux::params::clock,
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

  package { 'tmux':
    ensure => $version;
  }

  file { $conf_file:
    ensure => file,
    content => template("${module_name}/tmux.conf.erb");
  }

}
