require 'beaker-rspec'
require 'beaker/puppet_install_helper'
require 'beaker/testmode_switcher/dsl'

UNSUPPORTED_PLATFORMS = ['windows', 'Darwin']

run_puppet_install_helper

RSpec.configure do |c|
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  c.formatter = :documentation
  c.before :suite do
    hosts.each do |host|
      copy_module_to(host, :source => proj_root, :module_name => 'comments')
      on host, puppet('module','install','puppetlabs-stdlib'), { :acceptable_exit_codes => [0,1] }
    end
  end
end


class AcceptanceHelper
  def self.get_master
    hosts.find{ |x| x.host_hash[:roles].include?('master') } ? master : Nil
  end

  def self.agent_execute(manifest)
    Beaker::TestmodeSwitcher::DSL.execute_manifest(manifest, beaker_opts)
  end

  def self.make_remote_dir(host, directory)
    on(host, "test -d #{directory} || mkdir -p #{directory}")
  end

  def self.remote_dir_exists(host, directory)
    on(host, "test -d #{directory}")
  end

  def self.remote_file_exists(host, filepath)
    on(host, "test -f #{filepath}")
  end
end

def beaker_opts
  @env ||=
  {
    debug: true,
    trace: true,
    environment: { }
  }
end
