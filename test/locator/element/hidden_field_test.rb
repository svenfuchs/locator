require File.expand_path('../../../test_helper', __FILE__)
require 'locator/element'

class ElementHiddenFieldTest < Test::Unit::TestCase
  HiddenField = Locator::Element::HiddenField

  test "finds a hidden input" do
    html = '<input type="hidden" />'
    assert_equal 'input', HiddenField.new.locate(html).name
  end

  test "finds a hidden input by id" do
    html = '<input type="hidden" id="foo" />'
    assert_equal 'input', HiddenField.new.locate(html, 'foo').name
  end

  test "finds a hidden input by name" do
    html = '<input type="hidden" name="foo" />'
    assert_equal 'input', HiddenField.new.locate(html, 'foo').name
  end

  test "finds a hidden input by class" do
    html = '<input type="hidden" class="foo" />'
    assert_equal 'input', HiddenField.new.locate(html, :class => 'foo').name
  end

  test "does not find a hidden input when id does not match" do
    html = '<input type="hidden" id="bar" />'
    assert_nil HiddenField.new.locate(html, :class => 'foo')
  end

  test "does not find a hidden input when class does not match" do
    html = '<input type="hidden" class="bar" />'
    assert_nil HiddenField.new.locate(html, :class => 'foo')
  end
end
