#!/usr/bin/env rake
require "bundler/gem_tasks"
 
require 'rake/testtask'
 
Rake::TestTask.new do |t|
  t.libs << 'lib/frenchmofo.rb'
  t.test_files = FileList['test/lib/frenchmofo/*_test.rb']
  t.verbose = true
end
 
task :default => :test