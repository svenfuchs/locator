require File.expand_path('../../test_helper', __FILE__)
require 'locator/element'

class ElementTextAreaTest < Test::Unit::TestCase
  TextArea = Locator::Element::TextArea

  test "finds a textarea" do
    assert_locate '<textarea></textarea>', TextArea.new.xpath
  end

  test "finds a textarea by id" do
    assert_locate '<textarea id="foo"></textarea>', TextArea.new.xpath('foo')
  end

  test "finds a textarea by class" do
    assert_locate '<textarea class="foo"></textarea>', TextArea.new.xpath(:class => 'foo')
  end

  test "does not find a textarea when id does not match" do
    assert_no_locate '<textarea id="bar"></textarea>', TextArea.new.xpath(:class => 'foo')
  end

  test "does not find a textarea when class does not match" do
    assert_no_locate '<textarea class="bar"></textarea>', TextArea.new.xpath(:class => 'foo')
  end
end
