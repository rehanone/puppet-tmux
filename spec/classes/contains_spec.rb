# To check the correct dependencies are set up for tmux.

require 'spec_helper'
describe 'tmux' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }
      describe 'Testing the dependencies between the classes' do
        it { is_expected.to contain_class('tmux::install') }
        it { is_expected.to contain_class('tmux::config') }

        it { is_expected.to contain_class('tmux::install').that_comes_before('Class[tmux::config]') }
      end
    end
  end
end
