module Locator
  class Element
    class HiddenField < Input
      def initialize
        super(:type => :hidden)
      end
    end
  end
end
