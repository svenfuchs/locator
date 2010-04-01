# encoding: utf-8
require File.expand_path('../../test_helper', __FILE__)

class LocatorElementTest < Test::Unit::TestCase
  include Locator

  # xpath

  test "xpath without further arguments given" do
    assert_equal './/*', Element.new.xpath
  end

  test "xpath of an element with a node name" do
    xpath = Element.new(:div).xpath
    assert_equal './/div', xpath
  end

  test "xpath of an element with attributes" do
    xpath = Element.new(nil, :type => 'type', :class => 'class').xpath
    assert_equal ".//*[@type=\"type\"][contains(concat(' ', @class, ' '), concat(' ', \"class\", ' '))]", xpath
  end

  test "xpath of an element with node name and attributes" do
    xpath = Element.new(:div, :type => 'type', :class => 'class').xpath
    assert_equal ".//div[@type=\"type\"][contains(concat(' ', @class, ' '), concat(' ', \"class\", ' '))]", xpath
  end

  test "xpath of an element with multiple node name and attributes" do
    xpath = Element.new([:div, :p], :type => 'type').xpath
    assert_equal ".//div[@type=\"type\"] | .//p[@type=\"type\"]", xpath
  end

  test "xpath merges given attributes with element attributes" do
    xpath = Element.new(:div, :foo => 'foo').xpath(:bar => 'bar')
    assert xpath.include?(".//div")
    assert xpath.include?("[@foo=\"foo\"]") # humpf, unsorted hash
    assert xpath.include?("[@bar=\"bar\"]")
  end

  test "xpath with given xpath and attributes" do
    xpath = Element.new.xpath('.//div', :foo => 'foo')
    assert_equal ".//div[@foo=\"foo\"]", xpath
  end

  # all

  test "all selects all elements when given no attributes" do
    html = '<a class="foo"></a><p class="bar"></p>'
    elements = Element.new.all(html)
    assert_equal %w(html body a p), elements.map { |element| element.name }
  end

  test "all selects all nodes with given node name" do
    html = '<a class="foo"></a><p class="bar"></p>'
    elements = Element.new('a').all(html)
    assert_equal %w(a), elements.map { |element| element.name }
  end

  test "all selects all nodes with attribute given to initialize" do
    html = '<a class="foo"></a><p class="bar"></p>'
    elements = Element.new(:class => 'foo').all(html)
    assert_equal %w(a), elements.map { |element| element.name }
  end

  test "all selects all nodes with attribute given to all" do
    html = '<a class="foo"></a><p class="bar"></p>'
    elements = Element.new.all(html, :class => 'foo')
    assert_equal %w(a), elements.map { |element| element.name }
  end

  # locate

  test "locate selects an element based on the length of the matching value" do
    html = %(
      <a href="#">the link with extra text</a>
      <a href="http://www.some-very-long-url.com">the link ...</a>
    )
    element = Element.new.locate(html, 'the link')
    assert_equal 'the link ...', element.content
  end

  test "locate selects an element containing whitespace" do
    html = %(
      <a href="#">
        the
        link
      </a>
    )
    assert Element.new.locate(html, 'the link')
  end

  test "locate selects an element containing extra tags" do
    html = '<a href="#">the <span>link</span></a>'
    assert Element.new.locate(html, 'the link')
  end

  test "locate selects an element containing extra text (1)" do
    html = '<a href="#">the link &raquo;</label>'
    assert Element.new.locate(html, 'the link')
  end

  test "locate selects an element containing extra text (2)" do
    html = '<a href="#">(the link)</label>'
    assert Element.new.locate(html, 'the link')
  end

  test "does not find a link when id does not match" do
    html = '<a href="" id="bar"></a>'
    assert_nil Element.new.locate(html, :id => 'foo')
  end

  test "does not find a link when class does not match" do
    html = '<a href="" class="bar"></a>'
    assert_nil Element.new.locate(html, :class => 'foo')
  end

  test "locate using an xpath" do
    html = '<a class="foo" href="#"></a><a class="bar" href="#"></a>'
    assert_equal 'bar', Element::Link.new.locate(html, :xpath => '//a[@class="bar"]').attribute('class')
  end

  test "locate using a css selector" do
    html = '<a class="foo" href="#"></a><a class="bar" href="#"></a>'
    assert_equal 'bar', Element::Link.new.locate(html, :css => '.bar').attribute('class')
  end

  test "locate selects an element containing an umlaut" do
    html = '<a href="#">the lünk</a>'
    assert Element.new.locate(html, 'the lünk')
  end

  test "locate selects an element with an attribute containing an umlaut" do
    html = '<input type="text" value="München" />'
    assert Element.new.locate(html, :value => 'München')
  end
end
