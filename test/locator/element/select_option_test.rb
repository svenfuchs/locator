require File.expand_path('../../../test_helper', __FILE__)
require 'locator/element'

class ElementSelectOptionOptionTest < Test::Unit::TestCase
  SelectOption = Locator::Element::SelectOption

  test "finds an option" do
    assert_locate '<option></option>', SelectOption.new.xpath
  end

  test "finds an option by id" do
    assert_locate '<option id="foo"></option>', SelectOption.new.xpath('foo')
  end

  test "finds an option by value" do
    assert_locate '<option value="foo"></option>', SelectOption.new.xpath('foo')
  end

  test "finds an option by content" do
    assert_locate '<option>foo</option>', SelectOption.new.xpath('foo')
  end

  test "finds an option by class attribute" do
    assert_locate '<option class="foo"></option>', SelectOption.new.xpath(:class => 'foo')
  end

  test "does not find an option when id does not match" do
    assert_no_locate '<option id="bar"></option>', SelectOption.new.xpath(:class => 'foo')
  end

  test "does not find an option when class does not match" do
    assert_no_locate '<option class="bar"></option>', SelectOption.new.xpath(:class => 'foo')
  end
end
