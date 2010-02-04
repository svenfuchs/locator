module Locator
  class Element
    class ElementsList < Element
      attr_reader :elements

      def initialize(*elements)
        @elements = elements
      end

      def lookup(dom, selector, attributes)
        Result.new(elements.map { |element| element.send(:lookup, dom, selector, attributes) }.flatten)
      end
    end
  end
end