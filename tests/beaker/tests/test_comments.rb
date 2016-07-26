require 'erb'
require 'master_manipulator'
require 'beaker'
require 'beaker-rspec'
require 'beaker/testmode_switcher/dsl'

require 'pry'

test_name 'Test Comments with beaker'

#Get the ERB manifest:
comment_dir                = '/tmp/comments'
user                       = 'gregohardy'
comment                    = 'Ha! a funny thing!'
comment_file               = 'very_funny_comments.txt'
beaker_opts =
  {
    debug: true,
    trace: true,
    environment: { }
  }


local_files_root_path = ENV['FILES'] || Dir.pwd + '/tests/beaker/files/'
manifest_template     = File.join(local_files_root_path, 'comments.erb')
manifest_erb          = ERB.new(File.read(manifest_template)).result(binding)

step 'Inject "site.pp" on Master'
site_pp = create_site_pp(master, :manifest => manifest_erb)

step 'A puppet agent run to build the comments file:'
confine_block(:except, :roles => %w{master dashboard database}) do
  result = Beaker::TestmodeSwitcher::DSL.execute_manifest(site_pp, beaker_opts)
  assert_no_match(/Error:/, result.stderr, 'Unexpected error was detected!')
end
