module Locator
  class Element
    class File < Input
      def initialize
        super(:input, :type => :file)
      end
    end
  end
end
