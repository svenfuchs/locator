require File.expand_path('../../../test_helper', __FILE__)

class LocatorMatcherHaveContentTest < Test::Unit::TestCase
  include Locator::Matcher
  
  def setup
    @html = '<p><a class="foo">The link</a></p>'
  end
  
  test 'target matches a given text' do
    assert contain('The link').matches?(@html)
  end

  test 'target does not match a given text' do
    assert !contain('No link').matches?(@html)
  end
  
  test 'target matches a given regex' do
    assert contain(/The\slink/).matches?(@html)
  end

  test 'target does not match a given regex' do
    assert !contain(/No\slink/).matches?(@html)
  end
  
  test 'treats newslines as spaces' do
    assert contain('Some text').matches?("<p>Some\ntext</p>")
  end
end