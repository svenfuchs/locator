module Locator
  class Element
    class Area < Element
      def initialize
        super('area', :equals => [:id], :matches => [:alt])
      end
    end
  end
end