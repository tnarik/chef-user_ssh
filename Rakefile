#!/usr/bin/env rake
require 'rake/testtask'
require 'foodcritic'

Rake::TestTask.new do |t|
  t.test_files = FileList['test/unit/**/*_spec.rb']
  t.verbose = true
end

desc 'Runs foodcritic linter'
task :foodcritic do
  FoodCritic::Rake::LintTask.new do |t|
    t.options = { exclude_paths: ['spec'],
                  tags: ['~FC015']
    }
  end
end

begin
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new
rescue LoadError
  puts ">>>>> Kitchen gem not loaded, omitting tasks" unless ENV['CI']
end

task :default => [:foodcritic, :test]
