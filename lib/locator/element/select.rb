module Locator
  class Element
    class Select < LabeledElement
      def initialize
        super('select', [:id, :name])
      end
    end
  end
end