module Locator
  class Element
    class ElementsList
      attr_reader :elements
      
      def initialize(*elements)
        @elements = elements
      end
      
      def xpath(*args)
        elements.map { |element| element.xpath(*args) }.join(' | ')
      end
    end
  end
end