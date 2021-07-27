# Class: tmux::install
#
class tmux::install inherits tmux {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  if $tmux::package_manage {
    package { $tmux::package_name:
      ensure => $tmux::package_ensure,
    }

    if $tmux::package_ensure != 'absent' {
      if !defined(Package['git']) {
        package { 'git':
          ensure => present,
        }
      }

      vcsrepo { "${tmux::download_home}/ohmytmux":
        ensure   => latest,
        provider => git,
        source   => 'https://github.com/gpakosz/.tmux.git',
        revision => 'master',
        require  => Package['git'],
      }
    }
  }
}
