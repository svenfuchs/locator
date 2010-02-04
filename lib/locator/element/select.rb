module Locator
  class Element
    class Select < FormElement
      def initialize
        super('select', :equals => [:id, :name])
      end
    end
  end
end