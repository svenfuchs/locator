require File.expand_path('../../../test_helper', __FILE__)
require 'locator/element'

class ElementFormTest < Test::Unit::TestCase
  Form = Locator::Element::Form

  test "finds a form" do
    assert_locate '<form></form>', Form.new.xpath
  end

  test "finds a form by id" do
    assert_locate '<form id="foo"></form>', Form.new.xpath('foo')
  end

  test "finds a form by name" do
    assert_locate '<form name="foo"></form>', Form.new.xpath('foo')
  end

  test "finds a form by class" do
    assert_locate '<form class="foo"></form>', Form.new.xpath(:class => 'foo')
  end

  test "does not find a form when id does not match" do
    assert_no_locate '<form id="bar"></form>', Form.new.xpath(:class => 'foo')
  end

  test "does not find a form when class does not match" do
    assert_no_locate '<form class="bar"></form>', Form.new.xpath(:class => 'foo')
  end
end
