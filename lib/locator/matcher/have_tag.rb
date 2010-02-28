module Locator
  module Matcher
    class HaveTag
      attr_reader :selector, :options, :count, :block, :target
      
      def initialize(*args, &block)
        @options  = args.last.is_a?(Hash) ? args.pop : {}
        @selector = args.pop
        @count    = options.delete(:count)
        @block    = block
      end

      def matches?(target = nil)
        @target = target
        count ? match_count : !!match_element
      end
      
      def match_count
        elements = Locator.all(target, selector, options)
        elements = elements.select(&block) if block
        elements.size == count.to_i
      end
      
      def match_element
        element = Locator.locate(target, selector, options)
        element && block ? Locator.within(element) { block.call(element) } : element
      end

      def failure_message # TODO
        "expected following text to match selector #{selector.inspect} and #{options.inspect}:\n#{target}"
      end

      def negative_failure_message
        "expected following text to not match selector #{selector.inspect} and #{options.inspect}:\n#{target}"
      end

      # def squeeze_space(inner_text)
      #   (inner_text || '').gsub(/^\s*$/, "").squeeze("\n")
      # end
      # 
      # def content_message
      #   case @content
      #   when String
      #     "include \"#{@content}\""
      #   when Regexp
      #     "match #{@content.inspect}"
      #   end
      # end
    end
  end
end
