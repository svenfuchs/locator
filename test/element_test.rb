require File.expand_path('../test_helper', __FILE__)
require 'locator/element'

class ElementTest < Test::Unit::TestCase
  def xpath(*args)
    Locator::Element.new('foo', [:id, :content]).xpath(*args)
  end

  test "no selector given => finds all element" do
    assert_locate '<foo></foo><foo></foo>', xpath, ['<foo></foo>', '<foo></foo>']
  end
  
  test "given selector equals content => finds the element" do
    assert_locate '<foo>foo</foo>', xpath('foo')
  end
  
  test "given selector contained in content => finds the element" do
    assert_locate '<foo>foo!</foo>', xpath('foo')
  end
  
  test "given selector equals id => finds the element" do
    assert_locate '<foo id="foo"></foo>', xpath('foo')
  end
  
  test "given selector contained in id => does not find the element" do
    assert_no_locate '<foo id="foobar"></foo>', xpath('foo')
  end
  
  test "given attribute equals attribute => finds the element" do
    assert_locate '<foo class="foo">a</foo>', xpath(:class => 'foo')
  end
  
  test "given attribute contained in attribute => does not find the element" do
    assert_no_locate '<foo class="foo-bar">a</foo>', xpath(:class => 'foo')
  end
  
  test "selector + attributes => finds the element" do
    assert_locate '<foo class="foo" title="bar">bar</foo>', xpath('bar', :class => 'foo', :title => 'bar')
  end
end
