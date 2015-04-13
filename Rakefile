#!/usr/bin/env rake
require 'rake/testtask'
require 'foodcritic'

desc 'Runs foodcritic linter'
task :foodcritic do
  FoodCritic::Rake::LintTask.new do |t|
    t.options = { exclude_paths: ['spec'],
                  tags: ['~FC015']
    }
  end
end

task :default => [:foodcritic, :test]
