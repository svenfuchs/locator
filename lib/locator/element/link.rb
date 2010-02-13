module Locator
  class Element
    class Link < Element
      def initialize
        super(:a, nil, :href => true)
      end
    end
  end
end