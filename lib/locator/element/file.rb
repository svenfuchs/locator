module Locator
  class Element
    class File < Input
      def initialize
        super(:type => :file)
      end
    end
  end
end
