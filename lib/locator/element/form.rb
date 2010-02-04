module Locator
  class Element
    class Form < Element
      def initialize
        super('form', :equals => [:id, :name])
      end
    end
  end
end
