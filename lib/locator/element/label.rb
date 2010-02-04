module Locator
  class Element
    class Label < Element
      def initialize
        super('label', :equals => [:id, :content])
      end
    end
  end
end
