require File.expand_path('../../../test_helper', __FILE__)
require 'locator/element'

class ElementButtonTest < Test::Unit::TestCase
  Button = Locator::Element::Button

  test "finds a button" do
    assert_locate '<button></button>', Button.new.xpath
  end

  test "finds a submit input" do
    assert_locate '<input type="submit">', Button.new.xpath
  end

  test "finds a button input" do
    assert_locate '<input type="button">', Button.new.xpath
  end

  test "finds an image input" do
    assert_locate '<input type="image">', Button.new.xpath
  end

  test "does not find a checkbox input" do
    assert_no_locate '<input type="checkbox">', Button.new.xpath
  end
end
