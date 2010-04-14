require File.expand_path('../../../test_helper', __FILE__)

class LocatorMatcherHaveCssClassTest < Test::Unit::TestCase
  include Locator::Matcher
  
  test 'succeeds if a css class is contained in the classes list' do
    assert have_css_class('foo').matches?('foo bar baz')
    assert have_css_class('bar').matches?('foo bar baz')
    assert have_css_class('baz').matches?('foo bar baz')
  end

  test 'fails if a css class is not contained in the classes list' do
    assert !have_css_class('buz').matches?('foo bar baz')
  end

  test 'fails if a css class is contained in the classes list as part of a longer css class name' do
    assert !have_css_class('b').matches?('foo bar baz')
  end
end