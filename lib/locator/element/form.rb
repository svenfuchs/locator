module Locator
  class Element
    class Form < Element
      def initialize
        super(:form, :matches => [:name])
      end
    end
  end
end
