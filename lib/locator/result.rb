module Locator
  class Result < Array
    MATCH_TYPES = {
      :alt     => :contains,
      :title   => :contains,
      :content => :contains
    }

    class << self
      def matches?(name, value, selector)
        value, selector = Locator.decode(value), Locator.decode(selector) if Locator.decode_entities?
        value = normalize_whitespace(value)
        case selector
        when Regexp
          value =~ selector
        else
          type = MATCH_TYPES[name] || :equals
          send("#{type}?", value, selector)
        end
      end

      def equals?(value, selector)
        value == selector
      end

      def contains?(value, selector)
        value.include?(selector)
      end

      def normalize_whitespace(value)
        value.gsub(/\s+/, ' ').strip
      end
    end

    def filter!(selector, locatables)
      selector ? replace(filter(selector, locatables)) : self
    end

    def filter(selector, locatables)
      selector ? filter_by(selector, locatables) : self
    end

    def sort!
      each  { |element| element.matches.sort! }
      super { |lft, rgt| lft.matches.first.length <=> rgt.matches.first.length }
    end

    def +(other)
      replace(super)
    end

    protected

      def filter_by(selector, attributes)
        select do |element|
          Array(attributes).any? do |name|
            value = name == :content ? element.content : element.attribute(name.to_s)
            element.matches << value if self.class.matches?(name, value, selector)
          end
        end
      end
  end
end