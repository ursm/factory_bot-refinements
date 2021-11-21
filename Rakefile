require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new :spec

task default: %i(
  readme
  update
  spec:all
)

task :readme do
  sh 'handlematters README.md.hms > README.md'
end

task :update do
  sh 'bundle update'
  sh 'bundle exec appraisal clean'
  sh 'bundle exec appraisal generate'
end

task 'spec:all' do
  sh 'bundle exec appraisal rspec'
end
