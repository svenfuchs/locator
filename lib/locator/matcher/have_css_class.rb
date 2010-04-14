module Locator
  module Matcher
    class HaveCssClass
      attr_reader :target, :css_class
    
      def initialize(css_class)
        @css_class = css_class
      end

      def matches?(target = nil)
        @target = target
        " #{target} ".include?(" #{css_class} ")
      end

      def failure_message
        "expected #{target.inspect} to include the css class #{css_class.inspect}"
      end

      def negative_failure_message
        "expected #{target.inspect} not to include the css class #{css_class.inspect}"
      end
    end
  end
end