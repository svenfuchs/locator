require 'test/unit' # TODO make this optional, e.g. when Rspec or minitest are present

module Locator
  module Assertions
    include Test::Unit::Assertions, Matcher
    
    # Asserts that the response body contains the given string or regexp
    def assert_contains(*args)
      matcher = contain(*args)
      assert matcher.matches?(send(__response_accessor).body), matcher.failure_message
    end

    # Asserts that the response body does not contain the given string or regexp
    def assert_does_not_contain(*args)
      matcher = contain(*args)
      assert !matcher.matches?(send(__response_accessor).body), matcher.negative_failure_message
    end

    def assert_has_tag(html, *args, &block)
      matcher = have_tag(*args, &block)
      assert matcher.matches?(send(__response_accessor).body), matcher.failure_message
    end

    def assert_no_tag(html, *args, &block)
      matcher = have_tag(*args, &block)
      assert !matcher.matches?(send(__response_accessor).body), matcher.negative_failure_message
    end
    alias :assert_does_not_have_tag :assert_no_tag

    # Asserts that the response body matches the given XPath
    def assert_has_xpath(html, *args, &block)
      matcher = have_xpath(*args, &block)
      assert matcher.matches?(send(__response_accessor).body), matcher.failure_message
    end

    # Asserts that the response body does not match the given XPath
    def assert_no_xpath(html, *args, &block)
      matcher = have_xpath(*args, &block)
      assert !matcher.matches?(send(__response_accessor).body), matcher.negative_failure_message
    end
    alias :assert_does_not_have_xpath :assert_no_tag

    # Asserts that the response body matches the given CSS selector
    def assert_has_css(html, *args, &block)
      matcher = have_css(*args, &block)
      assert matcher.matches?(send(__response_accessor).body), matcher.failure_message
    end

    # Asserts that the response body does not match the given CSS selector
    def assert_no_css(html, *args, &block)
      matcher = have_css(*args, &block)
      assert !matcher.matches?(send(__response_accessor).body), matcher.negative_failure_message
    end
    alias :assert_does_not_have_css :assert_no_tag

    def assert_css_class(css_classes, css_class)
      matcher = HaveCssClass.new(css_class)
      assert matcher.matches?(css_classes.body), matcher.failure_message
    end

    def assert_no_css_class(css_classes, css_class)
      matcher = HaveCssClass.new(css_class)
      assert matcher.matches?(css_classes.body), matcher.negative_failure_message
    end
    alias :assert_does_not_include_css_class :assert_no_tag
    
    protected
    
      def __response_accessor
        # TODO should probably be a module accessor
        @__response_accessor ||= respond_to?(:last_response) ? :last_response : :response
      end
  end
end