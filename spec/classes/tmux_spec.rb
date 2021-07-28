require 'spec_helper'

describe 'tmux' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_class('tmux::install') }
      it { is_expected.to contain_class('tmux::config') }

      describe 'tmux::install' do
        let(:params) do
          {
            package_manage: true,
            package_ensure: 'present',
            package_name: 'tmux',
          }
        end

        it {
          is_expected.to contain_package('tmux').with_ensure('present')
        }

        it {
          is_expected.to contain_vcsrepo('/opt/tmux/ohmytmux')
            .with_ensure('latest')
            .with_provider('git')
            .with_source('https://github.com/gpakosz/.tmux.git')
            .with_revision('master')
        }

        describe 'should allow package ensure to be overridden' do
          let(:params) do
            {
              package_ensure: 'latest',
              package_name: 'tmux',
              package_manage: true,
            }
          end

          it {
            is_expected.to contain_package('tmux').with_ensure('latest')
          }
        end

        describe 'should allow the package name to be overridden' do
          let(:params) do
            {
              package_ensure: 'present',
              package_name: 'hambaby',
              package_manage: true,
            }
          end

          it {
            is_expected.to contain_package('hambaby')
          }
        end

        describe 'should allow the package to be unmanaged' do
          let(:params) do
            {
              package_manage: false,
              package_name: 'tmux',
            }
          end

          it {
            is_expected.not_to contain_package('tmux')
          }
        end
      end
    end
  end
end
