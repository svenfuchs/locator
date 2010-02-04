module Locator
  class Element
    class Field < ElementsList
      def initialize
        super(Input.new, TextArea.new)
      end
    end
  end
end