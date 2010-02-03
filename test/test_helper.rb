$:.unshift File.expand_path("../lib", File.dirname(__FILE__))
$:.unshift(File.expand_path(File.dirname(__FILE__)))

require 'test/unit'
require 'locator'

module TestMethod
  def self.included(base)
    base.class_eval do
      def test(name, &block)
        test_name = "test_#{name.gsub(/\s+/,'_')}".to_sym
        defined = instance_method(test_name) rescue false
        raise "#{test_name} is already defined in #{self}" if defined
        if block_given?
          define_method(test_name, &block)
        else
          define_method(test_name) do
            flunk "No implementation provided for #{name}"
          end
        end
      end
    end
  end
end

class Module
  include TestMethod
end

class Test::Unit::TestCase
  include TestMethod

  def dom(html)
    Locator::Dom.page(html)
  end
  
  def assert_locate(html, path, elements = nil)
    expected = Array(elements || html)
    result   = dom(html).elements_by_xpath(path).map(&:to_s)
    assert_equal expected, result
  end
  
  def assert_no_locate(html, path)
    assert_locate(html, path, [])
  end
end