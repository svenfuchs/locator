module Locator
  class Element
    class Field < ElementsList
      def initialize
        types = [:text, :password , :email, :url, :search, :tel, :color]
        super(LabeledElement.new('input', [:id, :name], :type => types), TextArea.new)
      end
    end
  end
end