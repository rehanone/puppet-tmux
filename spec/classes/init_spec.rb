require 'spec_helper'

osfamilies = {
  'ArchLinux' => { package: 'tmux' },
  'RedHat'    => { package: 'tmux' },
  'Debian'    => { package: 'tmux' },
}
conf_file = '/etc/tmux.conf'

describe 'tmux' do
  osfamilies.each do |osfamily, values|
    let(:facts) { {osfamily: osfamily} }
    context "on #{osfamily}" do
      context 'installs tmux package' do
        it { should contain_package(values[:package]) }
      end
      context 'removes tmux package' do
        let(:params) { { ensure: 'absent' } }
        it { should contain_package(values[:package]).with_ensure('absent') }
      end
      context 'installs config file with default values' do
        it { should contain_file(conf_file).without_content(/^set-option -g prefix .*$/) }
        it { should contain_file(conf_file).with_content(/^setw -g mode-keys vi$/) }
        it { should contain_file(conf_file).with_content(/^# setup status bar$/) }
        it { should contain_file(conf_file).with_content(/^set -g status-right .*#\(date.*$/) }
        it { should contain_file(conf_file).without_content(/set -g default-shell/) }
      end
      context 'installs config file with custom values' do
        let(:params) { {prefix_key: 'screen', vi_mode_keys: false, pretty_statusbar: false, clock: false, default_shell: 'zsh'} }
        it { should contain_file(conf_file).with_content(/^set-option -g prefix .*$/) }
        it { should contain_file(conf_file).without_content(/^setw -g mode-keys vi$/) }
        it { should contain_file(conf_file).without_content(/^# setup status bar$/) }
        it { should contain_file(conf_file).without_content(/^set -g status-right .*#\(date.*$/) }
        it { should contain_file(conf_file).with_content(/set -g default-shell zsh/) }
      end
    end #context on osfamily
  end #osfamilies.each
end #describe
