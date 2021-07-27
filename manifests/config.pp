# Class: tmux::config
#
class tmux::config () inherits tmux {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  create_resources('tmux::profile', $tmux::profiles)
}
