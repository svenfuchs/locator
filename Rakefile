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

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    require File.expand_path("../lib/locator/version", __FILE__)

    s.name = "locator"
    s.version = Locator::VERSION
    s.summary = "Generic html element locators for integration testing"
    s.email = "svenfuchs@artweb-design.de"
    s.homepage = "http://github.com/svenfuchs/locator"
    s.description = "Generic html element locators for integration testing"
    s.authors = ['Sven Fuchs']
    s.files =  FileList["[A-Z]*", "{lib,test,vendor}/**/*"]
    s.add_dependency 'htmlentities'
  end
rescue LoadError
  puts "Jeweler, or one of its dependencies, is not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end
