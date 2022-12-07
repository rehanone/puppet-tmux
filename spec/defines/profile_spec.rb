require 'spec_helper'

testcases = {
  'user1' => {
    params: {},
    expect: { profile_home: '/home/user1', profile_type: 'ohmytmux', ensure: 'link' },
  },
  'user2' => {
    params: { ensure: 'present' },
    expect: { profile_home: '/home/user2', profile_type: 'ohmytmux', ensure: 'link' },
  },
  'root' => {
    params: { ensure: 'absent' },
    expect: { profile_home: '/root', profile_type: 'ohmytmux', ensure: 'absent' },
  },
}

describe 'tmux::profile' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      testcases.each do |user, values|
        let(:pre_condition) do
          [
            'user{"root": }',
            'user {"user1": }',
            'user {"user2": }',
          ]
        end

        context "using case #{user}" do
          let(:title) { user }
          let(:params) { values[:params] }

          it do
            is_expected.to contain_file("#{values[:expect][:profile_home]}/.tmux.conf")
              .with_ensure(values[:expect][:ensure])
              .with_target('/opt/tmux/ohmytmux/.tmux.conf')
          end
        end
      end

      context 'using bad data' do
        let(:title) { 'user' }

        context 'using incorrect profile_type' do
          let(:params) { { profile_type: 'unknown' } }

          it { expect { is_expected.to compile }.to raise_error Exception }
        end
      end
    end
  end
end
