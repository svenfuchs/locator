require File.expand_path('../test_helper', __FILE__)
require 'locator/element'

class LocatorTest < Test::Unit::TestCase
  test "looks up a locator/element class by type" do
    assert_equal Locator::Element::Field, Locator[:field]
  end
  
  test "generates an xpath for type and given args" do
    path = Locator.xpath(:form, 'foo', :class => 'bar')
    assert_equal '//form[@class="bar"][@id="foo" or @name="foo"]', path
  end
  
  test "locates an element from html" do
    html = '<html><body><h1></h1><form class="bar"></form></body></html>'
    element = Locator.locate(html, :form, :class => 'bar')
    assert_equal '<form class="bar"></form>', element.to_s
  end
end