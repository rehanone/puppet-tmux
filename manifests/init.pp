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
  Boolean              $package_manage,
  String[1]            $package_name,
  String               $package_ensure,
  Stdlib::Absolutepath $download_home,
  Hash[String, Hash]   $profiles = lookup('tmux::profiles', Hash, 'hash', {}),
) {
  anchor { "${module_name}::begin": }
  -> class { "${module_name}::install": }
  -> class { "${module_name}::config": }
  -> anchor { "${module_name}::end": }
}
