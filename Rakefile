require 'rake/testtask'

require File.expand_path("../lib/locator/version", __FILE__)

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "locator"
    s.version = Locator::VERSION
    s.summary = "Generic html element locators for integration testing"
    s.email = "svenfuchs@artweb-design.de"
    s.homepage = "http://github.com/svenfuchs/locator"
    s.description = "Generic html element locators for integration testing"
    s.authors = ['Sven Fuchs']
    s.files =  FileList["[A-Z]*", "{lib,test,vendor}/**/*"]
  end
rescue LoadError
  puts "Jeweler, or one of its dependencies, is not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end
