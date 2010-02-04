require File.expand_path('../../../test_helper', __FILE__)

class ElementLabelTest < Test::Unit::TestCase
  Label = Locator::Element::Label

  test "finds a label" do
    html = '<label></label>'
    assert_equal 'label', Label.new.locate(html).tag_name
  end

  test "finds a label by id" do
    html = '<label id="foo"></label>'
    assert_equal 'label', Label.new.locate(html, 'foo').tag_name
  end

  test "finds a label by class" do
    html = '<label class="foo"></label>'
    assert_equal 'label', Label.new.locate(html, :class => 'foo').tag_name
  end

  test "does not find a label when id does not match" do
    html = '<label id="bar"></label>'
    assert_nil Label.new.locate(html, :class => 'foo')
  end

  test "does not find a label when class does not match" do
    html = '<label class="bar"></label>'
    assert_nil Label.new.locate(html, :class => 'foo')
  end
end
