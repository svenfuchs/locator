module Locator
  class Element
    class LabeledElement < Element
      def lookup(dom, selector, attributes)
        ids = element_ids(dom, selector)
        result = ids.empty? ? Result.new : super(dom, nil, attributes.merge(:id => ids))
        result.each { |element| element.matches << selector }
      end
      
      def element_ids(dom, selector)
        Label.new.send(:lookup, dom, selector).map { |element| element.attribute('for') }
      end
    end
  end
end
