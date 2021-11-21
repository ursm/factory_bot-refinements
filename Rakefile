require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new :spec

task default: %i(update spec:all readme)

task :update do
  sh 'bundle update'
  sh 'bundle exec appraisal update'
end

task 'spec:all' do
  sh 'bundle exec appraisal rspec'
end

task :readme do
  sh 'handlematters README.md.hms > README.md'
end
