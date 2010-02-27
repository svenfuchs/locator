module Locator
  module Matcher
    autoload :HaveTag, 'locator/matcher/have_tag'

    # Matches an HTML document with whatever string is given
    def contain(content)
      HaveTag.new(content)
    end

    # Asserts that the response body contains the given string or regexp
    def assert_contain(content)
      matcher = contain(content)
      assert matcher.matches?(response.body), matcher.failure_message
    end

    # Asserts that the response body does not contain the given string or regexp
    def assert_not_contain(*args)
      matcher = contain(content)
      assert !matcher.matches?(response.body), matcher.negative_failure_message
    end

    def have_tag(*args, &block)
      HaveTag.new(*args, &block)
    end

    def assert_have_tag(*args, &block)
      matcher = have_tag(*args, &block)
      assert matcher.matches?(response_body), matcher.failure_message
    end

    def assert_have_no_tag(*args, &block)
      matcher = have_tag(*args, &block)
      assert !matcher.matches?(response_body), matcher.negative_failure_message
    end

    # Matches HTML content against an XPath
    def have_xpath(xpath, options = {}, &block)
      HaveTag.new(options.delete(:content), options.merge(:xpath => xpath), &block)
    end
    alias_method :match_xpath, :have_xpath

    # Asserts that the response body matches the given XPath
    def assert_have_xpath(xpath, options = {}, &block)
      matcher = have_xpath(xpath, options = {}, &block)
      assert matcher.matches?(response_body), matcher.failure_message
    end

    # Asserts that the response body does not match the given XPath
    def assert_have_no_xpath(xpath, options = {}, &block)
      matcher = have_xpath(xpath, options = {}, &block)
      assert !matcher.matches?(response_body), matcher.negative_failure_message
    end

    # Matches HTML content against a CSS selector.
    def have_selector(css, options = {}, &block)
      HaveTag.new(options.delete(:content), options.merge(:css => css), &block)
    end
    alias_method :match_selector, :have_selector

    # Asserts that the response body matches the given CSS selector
    def assert_have_selector(css, options = {}, &block)
      matcher = have_selector(css, options = {}, &block)
      assert matcher.matches?(response.body), matcher.failure_message
    end

    # Asserts that the response body does not match the given CSS selector
    def assert_have_no_selector(css, options = {}, &block)
      matcher = have_selector(css, options = {}, &block)
      assert !matcher.matches?(response.body), matcher.negative_failure_message
    end

  end
end