require File.expand_path('../../test_helper', __FILE__)
require 'locator/element'

class ElementLinkTest < Test::Unit::TestCase
  Link = Locator::Element::Link

  test "finds a link" do
    assert_locate '<a href=""></a>', Link.new.xpath
  end

  test "finds a link by id" do
    assert_locate '<a href="" id="foo"></a>', Link.new.xpath('foo')
  end

  test "finds a link by class" do
    assert_locate '<a href="" class="foo"></a>', Link.new.xpath(:class => 'foo')
  end

  test "finds an link by content" do
    assert_locate '<a href="">foo</a>', Link.new.xpath('foo')
  end

  test "does not find an anchor" do
    assert_no_locate '<a name=""></a>', Link.new.xpath
  end

  test "does not find a link when id does not match" do
    assert_no_locate '<a href="" id="bar"></a>', Link.new.xpath(:class => 'foo')
  end

  test "does not find a link when class does not match" do
    assert_no_locate '<a href="" class="bar"></a>', Link.new.xpath(:class => 'foo')
  end
end
