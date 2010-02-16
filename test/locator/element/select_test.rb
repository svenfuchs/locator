require File.expand_path('../../../test_helper', __FILE__)

class ElementSelectTest < Test::Unit::TestCase
  Select = Locator::Element::Select

  test "finds a select" do
    html = '<select id="foo" class="foo"></select><select id="bar" class="bar"></select>'
    assert_equal 'select', Select.new.locate(html).name
  end

  test "finds a select by id" do
    html = '<select id="foo"></select>'
    assert_equal 'select', Select.new.locate(html, 'foo').name
  end

  test "finds a select by class" do
    html = '<select class="foo"></select>'
    assert_equal 'select', Select.new.locate(html, :class => 'foo').name
  end

  test "does not find a select when id does not match" do
    html = '<select id="bar"></select>'
    assert_nil Select.new.locate(html, :class => 'foo')
  end

  test "does not find a select when class does not match" do
    html = '<select class="bar"></select>'
    assert_nil Select.new.locate(html, :class => 'foo')
  end
end
