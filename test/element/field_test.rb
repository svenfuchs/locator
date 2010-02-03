require File.expand_path('../../test_helper', __FILE__)
require 'locator/element'

class ElementFieldTest < Test::Unit::TestCase
  Field = Locator::Element::Field

  test "finds a textarea" do
    assert_locate '<textarea></textarea>', Field.new.xpath
  end
  
  test "finds a text input" do
    assert_locate '<input type="text">', Field.new.xpath
  end
  
  test "finds a password input" do
    assert_locate '<input type="password">', Field.new.xpath
  end
  
  test "finds an email input" do
    assert_locate '<input type="email">', Field.new.xpath
  end
  
  test "finds a url input" do
    assert_locate '<input type="url">', Field.new.xpath
  end
  
  test "finds a search input" do
    assert_locate '<input type="search">', Field.new.xpath
  end
  
  test "finds a tel input" do
    assert_locate '<input type="tel">', Field.new.xpath
  end
  
  test "finds a color input" do
    assert_locate '<input type="color">', Field.new.xpath
  end

  test "finds a text input by name" do
    assert_locate '<input type="text" name="foo">', Field.new.xpath('foo')
  end

  test "finds a text input by class attribute" do
    assert_locate '<input type="text" class="foo">', Field.new.xpath(:class => 'foo')
  end

  test "finds a text input by label content" do
    html = '<label for="bar">foo</label><input type="text" id="bar">'
    assert_locate html, Field.new.xpath('foo'), '<input type="text" id="bar">'
  end
end
