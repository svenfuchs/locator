module Locator
  class Element
    class RadioButton < Input
      def initialize
        super(:type => :radio)
      end
    end
  end
end
