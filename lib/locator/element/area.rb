module Locator
  class Element
    class Area < Element
      def initialize
        super(:area, :matches => [:alt])
      end
    end
  end
end