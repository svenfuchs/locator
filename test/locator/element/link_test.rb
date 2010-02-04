require File.expand_path('../../../test_helper', __FILE__)

class LocatorElementLinkTest < Test::Unit::TestCase
  Link = Locator::Element::Link

  test "finds a link" do
    html = '<a class="foo"></a><a href="" class="bar"></a>'
    assert_equal 'bar', Link.new.locate(html).attribute('class')
  end

  test "finds a link by id" do
    html = '<a href="" id="foo"></a><a href="" id="bar"></a>'
    assert_equal 'bar', Link.new.locate(html, :id => 'bar').attribute('id')
  end

  test "finds a link by class" do
    html = '<a href="" class="foo"></a><a href="" class="bar"></a>'
    assert_equal 'bar', Link.new.locate(html, :class => 'bar').attribute('class')
  end

  test "finds a link by content" do
    html = '<a href="">foo</a><a href="">bar</a>'
    assert_equal 'bar', Link.new.locate(html, 'bar').content
  end

  test "does not find an anchor" do
    html = 
    assert_nil Link.new.locate('<a name="">foo</a>')
  end

  test "finds a link with a href starting with a slash" do
    html = '<a href="/foo/bar" class="foo"></a><a href="" class="bar"></a>'
    assert_equal '/foo/bar', Link.new.locate(html, :href => '/foo/bar').attribute('href')
  end
end

