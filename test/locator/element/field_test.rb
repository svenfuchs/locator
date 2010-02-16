require File.expand_path('../../../test_helper', __FILE__)
require 'locator/element'

class ElementFieldTest < Test::Unit::TestCase
  Field = Locator::Element::Field

  test "finds a textarea" do
    html = '<textarea></textarea>'
    assert_equal 'textarea', Field.new.locate(html).name
  end
  
  test "finds a text input" do
    html = '<input type="text">'
    assert_equal 'input', Field.new.locate(html).name
  end
  
  test "finds a password input" do
    html = '<input type="password">'
    assert_equal 'input', Field.new.locate(html).name
  end
  
  test "finds an email input" do
    html = '<input type="email">'
    assert_equal 'input', Field.new.locate(html).name
  end
  
  test "finds a url input" do
    html = '<input type="url">'
    assert_equal 'input', Field.new.locate(html).name
  end
  
  test "finds a search input" do
    html = '<input type="search">'
    assert_equal 'input', Field.new.locate(html).name
  end
  
  test "finds a tel input" do
    html = '<input type="tel">'
    assert_equal 'input', Field.new.locate(html).name
  end
  
  test "finds a color input" do
    html = '<input type="color">'
    assert_equal 'input', Field.new.locate(html).name
  end

  test "finds a text input by name" do
    html = '<input type="text" name="foo">'
    assert_equal 'input', Field.new.locate(html, 'foo').name
  end

  test "finds a text input by class attribute" do
    html = '<input type="text" class="foo">'
    assert_equal 'input', Field.new.locate(html, :class => 'foo').name
  end

  test "finds an input by label content" do
    html = '<label for="bar">foo</label><input type="text" id="bar">'
    assert_equal 'input', Field.new.locate(html, 'foo').name
  end

  test "finds an input by label content and input class" do
    html = '<label for="bar">foo</label><input type="text" id="bar" class="baz">'
    assert_equal 'input', Field.new.locate(html, 'foo', :class => 'baz').name
  end

  test "does not find a checkbox input" do
    html = '<input type="checkbox">'
    assert_nil Field.new.locate(html)
  end
end
