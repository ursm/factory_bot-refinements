require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new :spec

task default: %i(
  readme
  update
  spec
)

task :readme do
  sh 'handlematters README.md.hms > README.md'
end

task :update do
  sh 'bundle update --quiet'
end
