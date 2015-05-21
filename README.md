# puppet-tmux

[![Build Status](https://travis-ci.org/zanloy/puppet-tmux.svg?branch=master)](https://travis-ci.org/zanloy/puppet-tmux)

Manage tmux via puppet.

tmux is a terminal multiplexer. It lets you switch easily between several
programs in one terminal, detach them (they keep running in the background)
and reattach them to a different terminal. And do a lot more.

## Sample Usage
Install tmux and use the provided configuration defaults
```
class { '::tmux': }
```
Install tmux to replace GNU/screen
```
class { '::tmux':
  prefix_key => 'screen'
}
```
Uninstall tmux
```
class { '::tmux':
  ensure => absent,
}
```

## Class parameters
* ensure 
  * Accepted values: present or absent 
  * Default: present
  * Description: Whether or not tmux will be installed

* auto_update
  * Accepted values: true or false
  * Default: false
  * Description: Whether or not the tmux package should be automatically kept
    up-to-date using the distribution's packaging system

* conf_file
  * Accepted values: string
  * Default: /etc/tmux.conf
  * Description: Path to tmux's main configuration file.

* prefix_key
  * Accepted values: string or 'default' (CTRL+b) or 'screen' (CTRL+a)
  * Default: C-b
  * Description: Sets the prefix key you use to access tmux during a session.

* vi_mode_keys
  * Accepted values: true or false
  * Default: true
  * Description: Use vi mode keys for scrollbar, etc.

* pretty_statusbar
  * Accepted values: true or false
  * Default: true
  * Description: Adds a pretty statusbar to your session.

* clock
  * Accepted valued: true or false
  * Default: true
  * Description: Adds a clock to the status bar

* default_shell
  * Accepted values: string or default
  * Default: undefined
  * Description: Optionally specify a default shell.
