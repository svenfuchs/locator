module Locator
  class Element
    class Link < Element
      def initialize
        super(:a, :href => true)
      end
    end
  end
end