require File.expand_path('../../test_helper', __FILE__)
require 'locator/xpath'

class XpathBooleanTest < Test::Unit::TestCase
  Or, And = Locator::Boolean::Or, Locator::Boolean::And

  def setup
    Or.operator, And.operator = ' | ', ' & '
  end

  test "a | b => a | b" do
    path = Or.new('a', 'b').to_s
    assert_equal "a | b", path
  end

  test "a & b => a & b" do
    path = And.new('a', 'b').to_s
    assert_equal "a & b", path
  end

  test "(a & b) | c => a & b | c" do
    path = And.new('a', 'b').or('c').to_s
    assert_equal "a & b | c", path
  end

  test "(a | b) & c => a & c | b & c" do
    path = Or.new('a', 'b').and('c').to_s
    assert_equal "a & c | b & c", path
  end

  test "(a & b | c) & d => a & b & d | c & d" do
    path = And.new('a', 'b').or('c').and('d').to_s
    assert_equal "a & b & d | c & d", path
  end

  test "(a & b | c) & (d | e) => a & b & d | a & b & e | c & d | c & e" do
    path = And.new('a', 'b').or('c').and(Or.new('d', 'e')).to_s
    assert_equal "a & b & d | a & b & e | c & d | c & e", path
  end
end
