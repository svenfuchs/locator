# encoding: utf-8
require File.expand_path('../test_helper', __FILE__)

class LocatorTest < Test::Unit::TestCase
  include Locator

  # test "returns the element if given an element" do
  #   html = '<p></p>'
  #   element = locate(html, :p)
  #   assert_equal element, locate(html, element)
  # end

  test "looks up a locator/element class by type" do
    assert_equal Locator::Element::Field, Locator[:field]
  end

  test "generates an xpath for type and given args" do
    xpath = xpath(:form, :id => 'bar')
    assert_equal './/form[@id="bar"]', xpath
  end

  # locate

  test "locates the first element by node name" do
    html = '<html><body><form id="foo"></form><form id="bar"></form></body></html>'
    element = locate(html, :form)
    assert_equal 'foo', element.attribute('id')
  end

  test "locates the first element by xpath" do
    html = '<html><body><form id="foo"></form><form id="bar"></form></body></html>'
    element = locate(html, :xpath => '//form')
    assert_equal 'foo', element.attribute('id')
  end

  # within

  test "within scopes to a locator" do
    html = '<form></form><div id="bar"><form id="foo"></form></div>'
    element = within(html, :div, :id => 'bar') { locate(:form) }
    assert_equal 'foo', element.attribute('id')
  end

  test "within scopes to a css selector" do
    html = '<form></form><div id="bar"><form id="foo"></form></div>'
    element = within(html, '#bar') { locate(:form) }
    assert_equal 'foo', element.attribute('id')
  end

  test "within scopes to an xpath" do
    html = '<form></form><div id="bar"><form id="foo"></form></div>'
    element = within(html, '//div[@id="bar"]') { locate(:form) }
    assert_equal 'foo', element.attribute('id')
  end

  test "nested within blocks" do
    html = '<form></form><div><form><p id="foo"><p></form></div>'
    element = within(html, :div) { within(:form) { locate(:p) } }
    assert_equal 'foo', element.attribute('id')
  end

  test "locates scopes to :within option (css selector)" do
    html = '<form></form><div><form id="foo"></form></div>'
    element = locate(html, :form, :within => 'div')
    assert_equal 'foo', element.attribute('id')
  end

  test "locates scopes to :within option (xpath)" do
    html = '<form></form><div><form id="foo"></form></div>'
    element = locate(html, :form, :within => '//div')
    assert_equal 'foo', element.attribute('id')
  end

  test "within/locate with module included" do
    html = '<form></form><div><form id="foo"></form></div>'
    element = within(html, :div) { locate(:form) }
    assert_equal 'foo', element.attribute('id')
  end

  test "locate when given a block scopes the block to the located element" do
    html = '<p id="foo"><p><form></form><div><form><p id="bar"><p></form></div>'
    element = locate(html, :div) { locate(:form) { locate(:p) } }
    assert_equal 'bar', element.attribute('id')
  end

  test "locate does not yield the block when no element was found (would otherwise locate in global scope)" do
    html = '<form></form><div><form><p id="foo"><p></form></div>'
    assert_nil locate(html, :div) { locate(html, :form, :class => 'bar')  { locate(html, :p) } }
  end

  # locate with umlauts

  test "locates an element by encoded selector from html containing an encoded umlaut" do
    html = '<span>Berlin</span><span>M&uuml;nchen</span>'
    assert_equal 'München', locate(html, 'M&uuml;nchen').content
  end

  test "locates an element by encoded selector from html containing an non-encoded umlaut" do
    html = '<span>Berlin</span><span>München</span>'
    assert_equal 'München', locate(html, 'M&uuml;nchen').content
  end

  test "locates an element by non-encoded selector from html containing an encoded umlaut" do
    html = '<span>Berlin</span><span>M&uuml;nchen</span>'
    assert_equal 'München', locate(html, 'München').content
  end

  test "locates an element by non-encoded selector from html containing a non-encoded umlaut" do
    html = '<span>Berlin</span><span>München</span>'
    assert_equal 'München', locate(html, 'München').content
  end

  test "locates an element by encoded attribute from html containing an encoded umlaut" do
    html = '<input type="text" value="M&uuml;nchen">'
    assert_equal 'München', locate(html, :value => 'M&uuml;nchen').value
  end

  test "locates an element by encoded attribute from html containing an non-encoded umlaut" do
    html = '<input type="text" value="München">'
    assert_equal 'München', locate(html, :value => 'M&uuml;nchen').value
  end

  test "locates an element by non-encoded attribute from html containing an encoded umlaut" do
    html = '<input type="text" value="M&uuml;nchen">'
    assert_equal 'München', locate(html, :value => 'München').value
  end

  test "locates an element by non-encoded attribute from html containing a non-encoded umlaut" do
    html = '<input type="text" value="München">'
    assert_equal 'München', locate(html, :value => 'München').value
  end
end