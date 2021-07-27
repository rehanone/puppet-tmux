# tmux::profile
#
define tmux::profile (
  Boolean               $manage       = true,
  Enum[present, absent] $ensure       = present,
  Enum[ohmytmux]        $profile_type = ohmytmux,
  String                $profile_home = $title ? {
    'root'  => '/root',
    default => "/home/${title}"
  },
) {

  include tmux

  if $manage {
    case $profile_type {
      'ohmytmux': {
        $en = $ensure ? {
          'absent' => absent,
          default  => link,
        }
        file { "${profile_home}/.tmux.conf":
          ensure  => $en,
          target  => "${tmux::download_home}/ohmytmux/.tmux.conf",
          require => User[$title],
        }

        case $ensure {
          'absent': {
            file { "${profile_home}/.tmux.conf.local":
              ensure => absent,
            }
          }
          default: {
            exec {
              "cp-${title}-tmux.conf.local":
                creates   => "${profile_home}/.tmux.conf.local",
                cwd       => "${profile_home}/",
                command   => "cp ${tmux::download_home}/ohmytmux/.tmux.conf.local .",
                path      => ['/bin', '/usr/bin'],
                onlyif    => "getent passwd ${name} | cut -d : -f 6 | xargs test -e",
                user      => $name,
                loglevel  => debug,
                logoutput => true,
                returns   => ['0'],
                subscribe => Class["${module_name}::install"],
                require   => User[$title],
            }
          }
        }
      }
      default: {}
    }
  }
}
