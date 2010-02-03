require File.expand_path('../../test_helper', __FILE__)
require 'locator/element'

class ElementLinkTest < Test::Unit::TestCase
  Link = Locator::Element::Link

  test "no selector given => finds all links" do
    assert_locate '<a href=""></a><a href=""></a>', Link.new.xpath, ['<a href=""></a>', '<a href=""></a>']
  end
  
  test "given selector equals link content => finds the link" do
    assert_locate '<a href="">foo</a>', Link.new.xpath('foo')
  end
  
  test "given selector contained in link content => finds the link" do
    assert_locate '<a href="">foo!</a>', Link.new.xpath('foo')
  end
  
  test "given selector equals link id => finds the link" do
    assert_locate '<a href="" id="foo"></a>', Link.new.xpath('foo')
  end
  
  test "given selector contained in link id => does not find the link" do
    assert_no_locate '<a href="" id="foobar"></a>', Link.new.xpath('foo')
  end
  
  test "given attribute equals link attribute => finds the link" do
    assert_locate '<a href="" class="foo">a</a>', Link.new.xpath(:class => 'foo')
  end

  test "given attribute contained in link attribute => does not find the link" do
    assert_no_locate '<a href="" class="foo-bar">a</a>', Link.new.xpath(:class => 'foo')
  end

  test "selector + attributes => finds the link" do
    assert_locate '<a href="" class="foo" title="bar">bar</a>', Link.new.xpath('bar', :class => 'foo', :title => 'bar')
  end
  
  # test "foo" do
  #   path = Locator::Element::Field.new.xpath('foo') # , :class => 'bla'
  #   puts path
  # end
  
  # test "foo" do
  #   path = Locator::Element::Button.new.xpath('foo')
  #   puts path
  # end
end
