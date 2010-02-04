module Locator
  class Element
    autoload :Area,           'locator/element/area'
    autoload :Button,         'locator/element/button'
    autoload :CheckBox,       'locator/element/check_box'
    autoload :ElementsList,   'locator/element/elements_list'
    autoload :Field,          'locator/element/field'
    autoload :File,           'locator/element/file'
    autoload :Form,           'locator/element/form'
    autoload :FormElement,    'locator/element/form_element'
    autoload :HiddenField,    'locator/element/hidden_field'
    autoload :Input,          'locator/element/input'
    autoload :Label,          'locator/element/label'
    autoload :LabeledElement, 'locator/element/labeled_element'
    autoload :Link,           'locator/element/link'
    autoload :RadioButton,    'locator/element/radio_button'
    autoload :Select,         'locator/element/select'
    autoload :SelectOption,   'locator/element/select_option'
    autoload :TextArea,       'locator/element/text_area'

    attr_reader :name, :locatables, :attributes

    def initialize(name = nil, locatables = nil, attributes = nil)
      @name = name || '*'
      @locatables = { :equals => :id, :matches => :content }.merge(locatables || {})
      @attributes = attributes || {}
    end

    def locate(*args)
      all(*args).first
    end

    def all(dom, *args)
      attributes, selector = args.last.is_a?(Hash) ? args.pop : {}, args.pop
      result = lookup(dom, selector, attributes)
      result.sort! if selector
      result
    end

    def xpath(attributes = {})
      Xpath.new(name, self.attributes.merge(attributes)).to_s
    end

    protected

      def lookup(dom, selector, attributes = {})
        dom = dom.respond_to?(:elements_by_xpath) ? dom : Locator::Dom.page(dom)
        elements = dom.elements_by_xpath(xpath(attributes))
        Result.new(elements).filter!(selector, locatables)
      end
  end
end