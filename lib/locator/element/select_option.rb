module Locator
  class Element
    class SelectOption < Element
      def initialize
        super(:option, :matches => [:value, :content])
      end
    end
  end
end