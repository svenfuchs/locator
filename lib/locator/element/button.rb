module Locator
  class Element
    class Button < ElementsList
      def initialize
        input  = Element.new('input', { :equals => [:id, :name], :matches => [:value] }, :type => %w(submit button image))
        button = Element.new('button', :equals => [:id, :name], :matches => [:content])
        super(input, button)
      end
    end
  end
end