require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'rake'

PuppetLint.configuration.fail_on_warnings = true
PuppetLint.configuration.send('relative')
PuppetLint.configuration.send('disable_80chars')
PuppetLint.configuration.send('disable_class_inherits_from_params_class')
PuppetLint.configuration.send('disable_documentation')
PuppetLint.configuration.send('disable_single_quote_string_with_variables')
PuppetLint.configuration.ignore_paths = ["spec/**/*.pp", "pkg/**/*.pp"]

Rake::Task[:beaker].clear

namespace :acceptance do
  desc "Run rspec acceptance test"
  RSpec::Core::RakeTask.new(:rspec => [:spec_prep]) do |t|
    t.pattern = 'spec/acceptance'
  end

  desc 'Beaker acceptance tests'
  task :beaker do
     sh 'tests/beaker/run_acceptance.sh'
  end
end
