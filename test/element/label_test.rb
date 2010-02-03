require File.expand_path('../../test_helper', __FILE__)
require 'locator/element'

class ElementLabelTest < Test::Unit::TestCase
  Label = Locator::Element::Label

  test "finds a label" do
    assert_locate '<label></label>', Label.new.xpath
  end

  test "finds a label by id" do
    assert_locate '<label id="foo"></label>', Label.new.xpath('foo')
  end

  test "finds a label by class" do
    assert_locate '<label class="foo"></label>', Label.new.xpath(:class => 'foo')
  end

  test "does not find a label when id does not match" do
    assert_no_locate '<label id="bar"></label>', Label.new.xpath(:class => 'foo')
  end

  test "does not find a label when class does not match" do
    assert_no_locate '<label class="bar"></label>', Label.new.xpath(:class => 'foo')
  end
end
