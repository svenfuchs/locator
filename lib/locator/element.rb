class Locator
  class Element < Xpath
    autoload :Area,           'locator/element/area'
    autoload :Button,         'locator/element/button'
    autoload :ElementsList,   'locator/element/elements_list'
    autoload :Field,          'locator/element/field'
    autoload :Form,           'locator/element/form'
    autoload :Label,          'locator/element/label'
    autoload :LabeledElement, 'locator/element/labeled_element'
    autoload :Link,           'locator/element/link'
    autoload :Select,         'locator/element/select'
    autoload :SelectOption,   'locator/element/select_option'
    autoload :TextArea,       'locator/element/text_area'
    
    attr_reader :locatables

    def initialize(name = '*', locatables = [], attributes = {})
      super(name)
      @content = !!locatables.delete(:content)
      @locatables = locatables
      @attributes = attributes
    end

    def xpath(*args)
      attributes = Hash === args.last ? args.pop : {}
      compose(args.pop, attributes)
      to_s
    end

    protected
    
      def content?
        @content
      end

      def compose(selector, attributes)
        attributes = @attributes.merge(attributes)
        attributes.each { |name, value| and! equals(name, value) }
        terms = []
        terms << equals(locatables, selector) if selector
        terms << contains(selector) if content? && selector
        and!(terms) unless terms.empty?
      end
  end
end