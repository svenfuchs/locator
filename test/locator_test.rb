require File.expand_path('../test_helper', __FILE__)

class LocatorTest < Test::Unit::TestCase
  include Locator

  test "returns the element if given an element" do
    html = '<p></p>'
    element = Locator.locate(html, :p)
    assert_equal element, Locator.locate(html, element)
  end

  test "looks up a locator/element class by type" do
    assert_equal Locator::Element::Field, Locator[:field]
  end

  test "generates an xpath for type and given args" do
    xpath = Locator.xpath(:form, :id => 'bar')
    assert_equal './/form[@id="bar"]', xpath
  end

  # locate

  test "locates an element by node name" do
    html = '<html><body><form></form></body></html>'
    element = Locator.locate(html, :form)
    assert_equal 'form', element.tag_name
  end

  test "locates an element by xpath" do
    html = '<html><body><form></form></body></html>'
    element = Locator.locate(html, :xpath => '//form')
    assert_equal 'form', element.tag_name
  end

  # within

  test "within scopes to a locator" do
    html = '<form></form><div id="bar"><form id="foo"></form></div>'
    element = Locator.within(:div, :id => 'bar') { |scope| scope.locate(html, :form) }
    assert_equal 'foo', element.attribute('id')
  end

  test "within scopes to a css selector" do
    html = '<form></form><div id="bar"><form id="foo"></form></div>'
    element = Locator.within('#bar') { |scope| scope.locate(html, :form) }
    assert_equal 'foo', element.attribute('id')
  end

  test "within scopes to an xpath" do
    html = '<form></form><div id="bar"><form id="foo"></form></div>'
    element = Locator.within('//div[@id="bar"]') { |scope| scope.locate(html, :form) }
    assert_equal 'foo', element.attribute('id')
  end

  test "nested within blocks" do
    html = '<form></form><div><form><p id="foo"><p></form></div>'
    element = Locator.within(:div) { |scope| scope.within(:form) { |scope| scope.locate(html, :p) } }
    assert_equal 'foo', element.attribute('id')
  end

  test "locates scopes to :within option (css selector)" do
    html = '<form></form><div><form id="foo"></form></div>'
    element = Locator.locate(html, :form, :within => 'div')
    assert_equal 'foo', element.attribute('id')
  end

  test "locates scopes to :within option (xpath)" do
    html = '<form></form><div><form id="foo"></form></div>'
    element = Locator.locate(html, :form, :within => '//div')
    assert_equal 'foo', element.attribute('id')
  end

  test "within/locate with module included" do
    html = '<form></form><div><form id="foo"></form></div>'
    element = within(:div) { locate(html, :form) }
    assert_equal 'foo', element.attribute('id')
  end

  test "locate when given a block scopes the block to the located element" do
    html = '<form></form><div><form><p id="foo"><p></form></div>'
    element = locate(html, :div) { locate(html, :form)  { locate(html, :p) } }
    assert_equal 'foo', element.attribute('id')
  end

  test "locate does not yield the block when no element was found (would otherwise locate in global scope)" do
    html = '<form></form><div><form><p id="foo"><p></form></div>'
    assert_nil locate(html, :div) { locate(html, :form, :class => 'bar')  { locate(html, :p) } }
  end
end