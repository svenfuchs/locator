require File.expand_path('../../test_helper', __FILE__)
require 'locator/element'

class ElementSelectTest < Test::Unit::TestCase
  Select = Locator::Element::Select

  test "finds a select" do
    assert_locate '<select></select>', Select.new.xpath
  end

  test "finds a select by id" do
    assert_locate '<select id="foo"></select>', Select.new.xpath('foo')
  end

  test "finds a select by class" do
    assert_locate '<select class="foo"></select>', Select.new.xpath(:class => 'foo')
  end

  test "does not find a select when id does not match" do
    assert_no_locate '<select id="bar"></select>', Select.new.xpath(:class => 'foo')
  end

  test "does not find a select when class does not match" do
    assert_no_locate '<select class="bar"></select>', Select.new.xpath(:class => 'foo')
  end
end
