require 'core_ext/string/underscore'

class Locator
  autoload :Dom,     'locator/dom'
  autoload :Element, 'locator/element'
  autoload :Xpath,   'locator/xpath'

  class << self
    def [](type)
      locators[type.to_sym]
    end

    def xpath(type, *args)
      Locator[type].new.xpath(*args)
    end

    protected

      def locators
        @locators ||= Hash[*Element.constants.map do |name|
          [name.underscore.to_sym, Element.const_get(name)]
        end.flatten]
      end

      def scopes
        @scopes ||= []
      end

      def current_scope
        scopes.last
      end

      def within(*args)
        element = args.first.respond_to?(:xpath) ? args.first : locate_element(*args)
        scopes.push(element.xpath)
        result = yield
        scopes.pop
        result
      end
  end
  
  attr_reader :dom
  
  def initialize(dom)
    @dom = dom.respond_to?(:elements_by_xpath) ? dom : Dom.page(dom)
  end
  
  def locate(type, *args)
    path = Locator.xpath(type, *args)
    dom.elements_by_xpath(path).first
  end
end