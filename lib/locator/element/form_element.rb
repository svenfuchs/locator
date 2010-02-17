module Locator
  class Element
    class FormElement < Element
      def initialize(name, attributes = {})
        attributes[:matches] ||= []
        attributes[:matches] << :name
        super
      end

      def lookup(dom, selector, attributes)
        super(dom, selector, attributes) + LabeledElement.new(name).send(:lookup, dom, selector, attributes.dup)
      end
    end
  end
end
