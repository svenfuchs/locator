require 'core_ext/hash/except'
require 'core_ext/hash/slice'

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

    attr_reader :name, :css, :locatables, :attributes

    def initialize(name = nil, options = {})
      @name = name
      @attributes = options.slice!(:equals, :matches)
      @locatables = { :equals => :id, :matches => :content }.merge(options || {})
    end

    def locate(*args)
      all(*args).first
    end

    def all(scope, *args)
      attributes, selector = args.last.is_a?(Hash) ? args.pop : {}, args.pop
      result = lookup(scope, selector, attributes)
      result.sort! if selector
      result
    end

    def xpath(attributes = {})
      @xpath ||= Xpath.new(name || '*', self.attributes.merge(attributes)).to_s
    end

    protected

      def lookup(scope, selector, attributes = {})
        scope = scope.respond_to?(:elements_by_xpath) ? scope : Locator::Dom.page(scope)
        xpath, css = attributes.delete(:xpath), attributes.delete(:css)
        elements = css ? scope.elements_by_css(css) : scope.elements_by_xpath(xpath || xpath(attributes))
        Result.new(elements).filter!(selector, locatables)
      end
  end
end