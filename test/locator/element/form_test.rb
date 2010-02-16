require File.expand_path('../../../test_helper', __FILE__)
require 'locator/element'

class ElementFormTest < Test::Unit::TestCase
  Form = Locator::Element::Form

  test "finds a form" do
    html = '<form></form>'
    assert_equal 'form', Form.new.locate(html).name
  end

  test "finds a form by id" do
    html = '<form id="foo"></form>'
    assert_equal 'form', Form.new.locate(html, 'foo').name
  end

  test "finds a form by name" do
    html = '<form name="foo"></form>'
    assert_equal 'form', Form.new.locate(html, 'foo').name
  end

  test "finds a form by class" do
    html = '<form class="foo"></form>'
    assert_equal 'form', Form.new.locate(html, :class => 'foo').name
  end

  test "does not find a form when id does not match" do
    html = '<form id="bar"></form>'
    assert_nil Form.new.locate(html, :class => 'foo')
  end

  test "does not find a form when class does not match" do
    html = '<form class="bar"></form>'
    assert_nil Form.new.locate(html, :class => 'foo')
  end
end
