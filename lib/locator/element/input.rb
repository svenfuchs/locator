module Locator
  class Element
    class Input < FormElement
      def initialize(attributes = {})
        super(:input, :equals => [:id, :name], :type => [:text, :password , :email, :url, :search, :tel, :color])
      end
    end
  end
end
