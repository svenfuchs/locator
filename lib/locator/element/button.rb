module Locator
  class Element
    class Button < ElementsList
      def initialize
        input  = Element.new(:input, :matches => [:value], :type => %w(submit button image))
        button = Element.new(:button, :matches => [:content])
        super(input, button)
      end
    end
  end
end