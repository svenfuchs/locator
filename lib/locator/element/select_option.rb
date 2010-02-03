module Locator
  class Element
    class SelectOption < Element
      def initialize
        super('option', [:id, :value])
      end
    end
  end
end