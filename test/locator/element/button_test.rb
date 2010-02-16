require File.expand_path('../../../test_helper', __FILE__)
require 'locator/element'

class ElementButtonTest < Test::Unit::TestCase
  Button = Locator::Element::Button

  test "finds a button" do
    html = '<button></button>'
    assert_equal 'button', Button.new.locate(html).name
  end

  test "finds a submit input" do
    html = '<input type="submit">'
    assert_equal 'input', Button.new.locate(html).name
  end

  test "finds a button input" do
    html = '<input type="button">'
    assert_equal 'input', Button.new.locate(html).name
  end

  test "finds an image input" do
    html = '<input type="image">'
    assert_equal 'input', Button.new.locate(html).name
  end

  test "does not find a checkbox input" do
    html = '<input type="checkbox">'
    assert_nil Button.new.locate(html)
  end
end
