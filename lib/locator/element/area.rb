module Locator
  class Element
    class Area < Element
      def initialize
        super('area', [:id, :alt])
      end
    end
  end
end