module Locator
  class Element
    class TextArea < FormElement
      def initialize
        super('textarea', :equals => [:id, :name])
      end
    end
  end
end