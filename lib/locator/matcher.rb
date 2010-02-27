module Locator
  module Matcher
    autoload :HaveTag, 'locator/matcher/have_tag'

    # Matches an HTML document with whatever string is given
    def contain(*args)
      HaveTag.new(*args)
    end

    # Asserts that the response body contains the given string or regexp
    def assert_contain(*args)
      matcher = contain(*args)
      assert matcher.matches?(response.body), matcher.failure_message
    end

    # Asserts that the response body does not contain the given string or regexp
    def assert_not_contain(*args)
      matcher = contain(*args)
      assert !matcher.matches?(response.body), matcher.negative_failure_message
    end

    def have_tag(*args, &block)
      HaveTag.new(*args, &block)
    end

    def assert_have_tag(*args, &block)
      matcher = have_tag(*args, &block)
      assert matcher.matches?(response.body), matcher.failure_message
    end

    def assert_have_no_tag(*args, &block)
      matcher = have_tag(*args, &block)
      assert !matcher.matches?(response.body), matcher.negative_failure_message
    end

    # Matches HTML content against an XPath
    def have_xpath(xpath, options = {}, &block)
      HaveTag.new(options.delete(:content), options.merge(:xpath => xpath), &block)
    end

    # Asserts that the response body matches the given XPath
    def assert_have_xpath(xpath, options = {}, &block)
      matcher = have_xpath(xpath, options = {}, &block)
      assert matcher.matches?(response.body), matcher.failure_message
    end

    # Asserts that the response body does not match the given XPath
    def assert_have_no_xpath(xpath, options = {}, &block)
      matcher = have_xpath(xpath, options = {}, &block)
      assert !matcher.matches?(response.body), matcher.negative_failure_message
    end

    # Matches HTML content against a CSS selector.
    def have_css(css, options = {}, &block)
      HaveTag.new(options.delete(:content), options.merge(:css => css), &block)
    end

    # Asserts that the response body matches the given CSS selector
    def assert_have_css(css, options = {}, &block)
      matcher = have_css(css, options = {}, &block)
      assert matcher.matches?(response.body), matcher.failure_message
    end

    # Asserts that the response body does not match the given CSS selector
    def assert_have_no_css(css, options = {}, &block)
      matcher = have_css(css, options = {}, &block)
      assert !matcher.matches?(response.body), matcher.negative_failure_message
    end
  end
end