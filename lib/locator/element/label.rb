module Locator
  class Element
    class Label < Element
      def initialize
        super(:label, :matches => [:content])
      end
    end
  end
end
