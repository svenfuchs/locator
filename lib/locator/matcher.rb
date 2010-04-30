module Locator
  module Matcher
    autoload :HaveTag,      'locator/matcher/have_tag'
    autoload :HaveCssClass, 'locator/matcher/have_css_class'

    # Matches an HTML document with whatever string is given
    def contain(*args)
      HaveTag.new(*args)
    end

    def have_tag(*args, &block)
      HaveTag.new(*args, &block)
    end

    def have_xpath(xpath, options = {}, &block)
      HaveTag.new(options.delete(:content), options.merge(:xpath => xpath), &block)
    end

    def have_css(css, options = {}, &block)
      HaveTag.new(options.delete(:content), options.merge(:css => css), &block)
    end

    def have_css_class(css_class)
      HaveCssClass.new(css_class)
    end
  end
end