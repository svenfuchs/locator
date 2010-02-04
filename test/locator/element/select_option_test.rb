require File.expand_path('../../../test_helper', __FILE__)
require 'locator/element'

class ElementSelectOptionOptionTest < Test::Unit::TestCase
  SelectOption = Locator::Element::SelectOption

  test "finds an option" do
    html = '<option></option>'
    assert_equal 'option', SelectOption.new.locate(html).tag_name
  end

  test "finds an option by id" do
    html = '<option id="foo"></option>'
    assert_equal 'option', SelectOption.new.locate(html, 'foo').tag_name
  end

  test "finds an option by value" do
    html = '<option value="foo"></option>'
    assert_equal 'option', SelectOption.new.locate(html, 'foo').tag_name
  end

  test "finds an option by content" do
    html = '<option>foo</option>'
    assert_equal 'option', SelectOption.new.locate(html, 'foo').tag_name
  end

  test "finds an option by class attribute" do
    html = '<option class="foo"></option>'
    assert_equal 'option', SelectOption.new.locate(html, :class => 'foo').tag_name
  end

  test "does not find an option when id does not match" do
    html = '<option id="bar"></option>'
    assert_nil SelectOption.new.locate(html, :class => 'foo')
  end

  test "does not find an option when class does not match" do
    html = '<option class="bar"></option>'
    assert_nil SelectOption.new.locate(html, :class => 'foo')
  end
end
