require 'core_ext/hash/except'
require 'core_ext/hash/slice'

module Locator
  class Element
    autoload :Area,           'locator/element/area'
    autoload :Button,         'locator/element/button'
    autoload :CheckBox,       'locator/element/check_box'
    autoload :Content,        'locator/element/content'
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

    def initialize(*args)
      @attributes, @name = args.last.is_a?(Hash) ? args.pop : {}, args.pop
      @locatables = (attributes.delete(:matches) || [:content]) << :id
    end

    def locate(*args)
      all(*args).first # || raise(ElementNotFound.new(*args))
    end

    def all(scope, *args)
      attributes, selector = args.last.is_a?(Hash) ? args.pop : {}, args.pop
      result = lookup(scope, selector, attributes)
      result.sort! if selector
      result
    end

    def xpath(*args)
      options    = args.last.is_a?(Hash) ? args.pop : {}
      attributes = self.attributes.merge(options.except(:xpath, :css)) # TODO move to Xpath?
      xpath, css = options.values_at(:xpath, :css)

      xpath ||= css ? ::Nokogiri::CSS.xpath_for(*css).first : args.pop
      Xpath.new(xpath || name || '*', attributes).to_s
    end

    protected

      def lookup(scope, selector, attributes = {})
        scope = scope.respond_to?(:elements_by_xpath) ? scope : Locator::Dom.page(scope)
        xpath = xpath(attributes)
        xpath = ".#{xpath}" unless xpath[0, 1] == '.'

        elements = scope.elements_by_xpath(xpath)
        Result.new(elements).filter!(selector, locatables)
      end
  end
end