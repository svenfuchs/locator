module Locator
  class Element
    class FormElement < Element
      def lookup(dom, selector, attributes)
        super(dom, selector, attributes) + LabeledElement.new(name).send(:lookup, dom, selector, attributes)
      end
    end
  end
end
