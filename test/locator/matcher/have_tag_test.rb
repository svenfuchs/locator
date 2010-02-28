require File.expand_path('../../../test_helper', __FILE__)

class LocatorMatcherHaveTagTest < Test::Unit::TestCase
  include Locator::Matcher

  def setup
    @html = '<p><a class="foo">The link</a></p>'
  end

  # given a selector

  test 'target matches a given selector' do
    assert have_tag('The link').matches?(@html)
  end

  test 'target does not match a given selector' do
    assert !have_tag('No link').matches?(@html)
  end

  # given an xpath

  test 'target matches a given xpath' do
    assert have_tag(:xpath => '//p/a[@class="foo"]').matches?(@html)
  end

  test 'target does not match a given xpath' do
    assert !have_tag(:xpath => '//p/a[@id="foo"]').matches?(@html)
  end

  # given a css selector

  test 'target matches a given css' do
    assert have_tag(:css => 'p a.foo').matches?(@html)
  end

  test 'target does not match a given css' do
    assert !have_tag(:css => 'p a#foo').matches?(@html)
  end

  # given a selector and xpath

  test 'target matches a given selector and xpath' do
    assert have_tag('The link', :xpath => '//p/a').matches?(@html)
  end

  test 'target does not match a given (wrong) selector and xpath' do
    assert !have_tag('No link', :xpath => '//p/a').matches?(@html)
  end

  test 'target does not match a given selector and (wrong) xpath' do
    assert !have_tag('The link', :xpath => '//p/div').matches?(@html)
  end

  # given a selector and css selector

  test 'target matches a given selector and css selector' do
    assert have_tag('The link', :css => 'p a').matches?(@html)
  end

  test 'target does not match a given (wrong) selector and css selector' do
    assert !have_tag('No link', :css => 'p a').matches?(@html)
  end

  test 'target does not match a given selector and (wrong) css selector' do
    assert !have_tag('The link', :css => 'p div').matches?(@html)
  end

  # given an xpath and attributes

  test 'target matches a given xpath and attributes' do
    assert have_tag(:xpath => '//p/a', :class => 'foo').matches?(@html)
  end

  test 'target does not match a given (wrong) xpath and attributes' do
    assert !have_tag(:xpath => '//p/div', :class => 'foo').matches?(@html)
  end

  test 'target does not match a given xpath and (wrong) attributes' do
    assert !have_tag(:xpath => '//p/a', :id => 'foo').matches?(@html)
  end

  # given selector, xpath and attributes

  test 'target matches a given selector, xpath and attributes' do
    assert have_tag('The link', :xpath => '//p/a', :class => 'foo').matches?(@html)
  end

  test 'target does not match a given (wrong) selector, xpath and attributes' do
    assert !have_tag('The link', :xpath => '//p/div', :class => 'foo').matches?(@html)
  end

  test 'target does not match a given selector, (wrong) xpath and attributes' do
    assert !have_tag('No link', :xpath => '//p/a', :class => 'foo').matches?(@html)
  end

  test 'target does not match a given selector, xpath and (wrong) attributes' do
    assert !have_tag('The link', :xpath => '//p/a', :class => 'bar').matches?(@html)
  end

  # given a selector, css selector and attributes

  test 'target matches a given selector, css selector and attributes' do
    assert have_tag('The link', :css => 'p a', :class => 'foo').matches?(@html)
  end

  test 'target does not match a given (wrong) selector, css selector and attributes' do
    assert !have_tag('The link', :css => 'p div', :class => 'foo').matches?(@html)
  end

  test 'target does not match a given selector, (wrong) css selector and attributes' do
    assert !have_tag('No link', :css => 'p a', :class => 'foo').matches?(@html)
  end

  test 'target does not match a given selector, css selector and (wrong) attributes' do
    assert !have_tag('The link', :css => 'p a', :class => 'bar').matches?(@html)
  end

  # using a block

  test 'given block selects from matched elements (block yields true)' do
    assert have_tag(:xpath => '//p') { true }.matches?(@html)
  end

  test 'given block selects from matched elements (block yields false)' do
    assert !have_tag(:xpath => '//p') { false }.matches?(@html)
  end

  test 'can use have_path in the given block' do
    assert have_tag(:xpath => '//p') { assert have_tag(:xpath => '//a').matches?(nil); true }.matches?(@html)
  end

  test 'uses a relative path when called in a block' do
    assert have_tag(:xpath => '//p') { assert have_tag(:xpath => '//a').matches?(nil); true }.matches?(@html)
  end

  test 'does not match parent tags called in a block' do
    assert have_tag(:xpath => '//a') { assert !have_tag(:xpath => '//p').matches?(nil); true }.matches?(@html)
  end

  # counting matches

  test 'target contains the given number of elements' do
    assert have_tag(:xpath => '//p/a', :count => 1).matches?(@html)
  end

  test 'target does not contain the given number of elements' do
    assert !have_tag(:xpath => '//p/a', :count => 2).matches?(@html)
  end

  test 'target contains the given number of elements when used with a block' do
    assert have_tag(:xpath => '//p/a', :count => 1) { |element| element.name == 'a' }.matches?(@html)
  end

  test 'target does not contain the given number of elements when used with a block (too few elements)' do
    assert !have_tag(:xpath => '//p/a', :count => 2) { |element| element.name == 'a' }.matches?(@html)
  end

  test 'target does not contain the given number of elements when used with a block (block does not match)' do
    assert !have_tag(:xpath => '//p/a', :count => 1) { |element| element.name == 'div' }.matches?(@html)
  end
end