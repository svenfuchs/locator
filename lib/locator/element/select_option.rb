module Locator
  class Element
    class SelectOption < Element
      def initialize
        super('option', :equals => [:id, :value, :content])
      end
    end
  end
end