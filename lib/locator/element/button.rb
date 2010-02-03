class Locator
  class Element
    class Button < ElementsList
      def initialize
        input  = Element.new('input',  [:id, :name, :value, :alt], :type => %w(submit button image))
        button = Element.new('button', [:id, :name, :content])
        super(input, button)
      end
    end
  end
end