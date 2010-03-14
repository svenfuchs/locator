require File.expand_path('../../test_helper', __FILE__)
require 'locator/xpath'

class XpathTest < Test::Unit::TestCase
  Xpath = Locator::Xpath

  def setup
    Locator::Boolean::Or.operator, Locator::Boolean::And.operator = ' | ', ''
  end

  test "simple xpath" do
    path = Xpath.new('input').to_s
    assert_equal ".//input", path
  end

  test "xpath with alternate nodenames" do
    path = Xpath.new(['input', 'button']).to_s
    assert_equal ".//input | .//button", path
  end

  test "xpath with attributes" do
    path = Xpath.new(['input', 'button'], :type => 'text', :id => 'foo')
    assert_equal %(.//input[@type="text"][@id="foo"] | .//button[@type="text"][@id="foo"]), path.to_s
  end

  test "xpath with alternate nodenames and attributes" do
    path = Xpath.new(['input', 'button']).to_s
    assert_equal ".//input | .//button", path
  end
  
  test "attribute equals to one of multiple values" do
    path = Xpath.new('input', :type => [:text, :password]).to_s
    assert_equal %(.//input[@type="text" or @type="password"]), path
  end
  
  test "one of multiple attributes equals to value" do
    path = Xpath.new('input', [:id, :name] => 'foo').to_s
    assert_equal %(.//input[@id="foo" or @name="foo"]), path
  end
  
  test "one of multiple attributes equals to one of multiple values" do
    path = Xpath.new('input', [:id, :name] => ['foo', 'bar']).to_s
    assert_equal %(.//input[@id="foo" or @id="bar" or @name="foo" or @name="bar"]), path
  end
end
