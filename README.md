# puppet-tmux

[![Build Status](https://travis-ci.com/rehanone/puppet-tmux.svg?branch=master)](https://travis-ci.com/rehanone/puppet-tmux)

This module is a clone of [zanloy/tmux](https://forge.puppet.com/modules/zanloy/tmux).
It removes the global /etc/tmux.conf based config file in favor of using [ohmytmux](https://github.com/gpakosz/.tmux)
on per user profile level.

Manage tmux via puppet.

tmux is a terminal multiplexer. It lets you switch easily between several
programs in one terminal, detach them (they keep running in the background)
and reattach them to a different terminal. And do a lot more.

## Sample Usage
Install tmux and use the provided configuration defaults
```
class { 'tmux': }
```
Install tmux with different package management options
```
class { '::tmux':
  package_manage => true,
  package_name   => 'tmux',
  package_ensure => 'latest',
}
```
Uninstall tmux
```
class { '::tmux':
  package_ensure => 'absent',
}
```

## Class parameters
* package_ensure 
  * Accepted values: present, absent, latest 
  * Default: present
  * Description: Whether or not tmux will be installed

* package_manage
  * Accepted values: true or false
  * Default: true
  * Description: Whether or not this module will be allowed to manage tmux package using system package manager.

* package_name
  * Accepted values: non-empty string
  * Default: tmux
  * Description: Lets you override the default package name on a given system.

All of this data can be provided through `Hiera`.

**YAML**
```yaml
tmux::package_manage: true
tmux::package_ensure: present
tmux::package_name: 'tmux'
tmux::download_home: '/opt/tmux'
tmux::profiles:
  root:
    manage: true
    ensure: present
  user1:
    manage: true
    ensure: present
  user2:
    manage: true
    ensure: absent
```

