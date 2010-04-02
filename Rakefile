require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Run all tests.'
Rake::TestTask.new(:test) do |t|
  load 'test/all.rb'
end