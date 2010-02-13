module Locator
  class Element
    class Input < FormElement
      def initialize(attributes = {})
        attributes = { :type => [:text, :password , :email, :url, :search, :tel, :color] }.merge(attributes)
        matchables = { :equals => [:id, :name] }
        super(:input, { :equals => [:id, :name] }, attributes)
      end
    end
  end
end
