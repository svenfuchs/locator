require 'core_ext/string/underscore'

module Locator
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

    def locate(html, type, *args)
      dom  = Locator::Dom.page(html)
      path = Locator.xpath(type, *args)
      dom.elements_by_xpath(path).first
    end

    protected

      def locators
        @locators ||= Hash[*Element.constants.map do |name|
          [name.underscore.to_sym, Element.const_get(name)]
        end.flatten]
      end
  end
end