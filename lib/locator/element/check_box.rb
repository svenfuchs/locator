module Locator
  class Element
    class CheckBox < Input
      def initialize
        super(:type => :checkbox)
      end
    end
  end
end
