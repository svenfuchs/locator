module Locator
  class Element
    class Form < Element
      def initialize
        super('form', [:id, :name])
      end
    end
  end
end
