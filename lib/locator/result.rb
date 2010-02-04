module Locator
  class Result < Array
    class << self
      def equals?(value, selector)
        value == selector
      end

      def matches?(value, selector)
        value = normalize_whitespace(value)
        Regexp === selector ? value =~ selector : value.include?(selector)
      end

      def normalize_whitespace(value)
        value.gsub(/\s+/, ' ').strip
      end
    end

    def filter!(selector, locatables)
      selector ? replace(filter(selector, locatables)) : self
    end

    def filter(selector, locatables)
      selector ? locatables.map { |(type, attrs)| filter_by(type, selector, attrs) }.flatten : self
    end

    def sort!
      each  { |element| element.matches.sort! }
      super { |lft, rgt| lft.matches.first.length <=> rgt.matches.first.length }
    end

    def +(other)
      replace(super)
    end

    protected

      def filter_by(type, selector, attributes)
        select do |element|
          Array(attributes).any? do |name|
            value = name == :content ? element.content : element.attribute(name.to_s)
            element.matches << value if self.class.send("#{type}?", value, selector)
          end
        end
      end
  end
end