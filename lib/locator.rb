require 'core_ext/string/underscore'

class Locator
  autoload :Actions, 'locator/actions'
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
  end

  attr_reader :dom, :scopes

  def initialize(dom)
    @dom = dom.respond_to?(:elements_by_xpath) ? dom : Dom.page(dom)
    @scopes = []
  end

  def locate(type, *args)
    options = Hash === args.last ? args.last : {}
    if scope = options.delete(:within)
      within(scope) { locate(type, *args) }
    else
      path = type.is_a?(Symbol) ? Locator.xpath(type, *args) : type
      scope = scopes.pop || dom
      scope.elements_by_xpath(path).first
    end
  end

  # TODO currently only take an xpath or element
  def within(scope, &block)
    scope = scope.is_a?(Hash) ? scope.delete(:xpath) : scope
    scope = locate(scope) unless scope.respond_to?(:xpath)
    scopes.push(scope)
    instance_eval(&block)
  end
end