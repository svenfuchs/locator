# encoding: utf-8

require File.expand_path('../lib/locator/version', __FILE__)

Gem::Specification.new do |s|
  s.name         = 'locator'
  s.version      = Locator::VERSION
  s.authors      = ['Sven Fuchs']
  s.email        = 'svenfuchs@artweb-design.de'
  s.homepage     = 'http://github.com/svenfuchs/locator'
  s.summary      = 'Generic html element locators for integration testing'
  s.description  = 'Generic html element locators for integration testing.'
  s.files        = Dir['{lib/**/*,[A-Z]*}']

  s.add_runtime_dependency 'htmlentities', '>= 4.2.0'

  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'
  s.rubyforge_project = '[none]'
  s.required_rubygems_version = '>= 1.3.6'
end