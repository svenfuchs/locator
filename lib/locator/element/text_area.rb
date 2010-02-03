module Locator
  class Element
    class TextArea < LabeledElement
      def initialize
        super('textarea', [:id, :name])
      end
    end
  end
end