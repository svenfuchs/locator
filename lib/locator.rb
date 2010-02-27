require 'core_ext/string/underscore'

module Locator
  autoload :Boolean, 'locator/boolean'
  autoload :Dom,     'locator/dom'
  autoload :Element, 'locator/element'
  autoload :Result,  'locator/result'
  autoload :Xpath,   'locator/xpath'

  class << self
    def [](type)
      locators[type.to_sym] || raise("unknown locator type: #{type}")
    end

    def build(type)
      locator = locators[type.to_sym] if type
      locator ? locator.new : Locator::Element.new(type)
    end

    protected

      def locators
        @locators ||= Hash[*Element.constants.map do |name|
          [name.underscore.to_sym, Element.const_get(name)]
        end.flatten]
      end
  end

  def xpath(*args)
    type = args.shift if args.first.is_a?(Symbol)
    Locator[type].new.xpath(*args)
  end

  def locate(dom, *args, &block)
    return args.first if args.first.respond_to?(:elements_by_xpath)

    options = Hash === args.last ? args.last : {}
    result = if scope = options.delete(:within)
      within(*Array(scope)) { locate(dom, *args) }
    else
      type = args.shift if args.first.is_a?(Symbol)
      Locator.build(type).locate(current_scope(dom), *args)
    end

    result && block_given? ? within(result) { yield(self) } : result
  end

  def within(*scope)
    scopes.push(scope)
    yield(self)
  end

  protected

    def current_scope(dom)
      dom = Locator::Dom.page(dom) unless dom.respond_to?(:elements_by_xpath)

      case (scope = scopes.pop) && scope.first
      when NilClass
        dom
      when %r(^\.?//)
        dom.elements_by_xpath(scope.first).first
      when String
        dom.elements_by_css(scope.first).first
      when Dom::Element
        Locator::Dom.page(scope.first.to_s) # FIXME should use scope.first instead
      else
        locate(dom, *scope)
      end
    end

    def scopes
      @scopes ||= []
    end

  extend(self)
end