require File.expand_path('../../../test_helper', __FILE__)
require 'locator/element'

class ElementTextAreaTest < Test::Unit::TestCase
  TextArea = Locator::Element::TextArea

  test "finds a textarea" do
    html = '<textarea></textarea>'
    assert_equal 'textarea', TextArea.new.locate(html).name
  end

  test "finds a textarea by id" do
    html = '<textarea id="foo"></textarea>'
    assert_equal 'textarea', TextArea.new.locate(html, 'foo').name
  end

  test "finds a textarea by class" do
    html = '<textarea class="foo"></textarea>'
    assert_equal 'textarea', TextArea.new.locate(html, :class => 'foo').name
  end

  test "does not find a textarea when id does not match" do
    html = '<textarea id="bar"></textarea>'
    assert_nil TextArea.new.locate(html, :class => 'foo')
  end

  test "does not find a textarea when class does not match" do
    html = '<textarea class="bar"></textarea>'
    assert_nil TextArea.new.locate(html, :class => 'foo')
  end
end
