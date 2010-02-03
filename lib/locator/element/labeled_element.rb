module Locator
  class Element
    class LabeledElement < Element
      attr_reader :labeled

      def initialize(name = '*', locatables = [], attributes = {})
        @labeled = Element.new(name, [], attributes)
        super
      end

      def compose(selector, attributes)
        super
        replace(self + labeled.and("[@id=//label[contains(.,\"#{selector}\")]/@for]")) if selector
      end
    end
  end
end
