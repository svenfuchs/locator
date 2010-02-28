require 'core_ext/string/underscore'

module Locator
  autoload :Boolean, 'locator/boolean'
  autoload :Dom,     'locator/dom'
  autoload :Element, 'locator/element'
  autoload :Matcher, 'locator/matcher'
  autoload :Result,  'locator/result'
  autoload :Xpath,   'locator/xpath'

  class ElementNotFound < StandardError
    def initialize(*args)
      super "could not find element type: #{args.map { |arg| arg.inspect }.join(', ') }"
    end
  end

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

  def all(dom, *args)
    return args.first if args.first.respond_to?(:elements_by_xpath)
    _lookup(:all, dom, *args)
  end

  def locate(dom, *args, &block)
    return args.first if args.first.respond_to?(:elements_by_xpath)
    result = _lookup(:locate, dom, *args)
    result && block_given? ? within(result) { yield(result) } : result
  end

  def within(*scope)
    scopes.push(scope)
    yield
  end

  protected
  
    def _lookup(method, dom, *args)
      options = Hash === args.last ? args.last : {}
      result = if scope = options.delete(:within)
        within(*Array(scope)) { send(method, dom, *args) }
      else
        type  = args.shift if args.first.is_a?(Symbol)
        scope = current_scope(dom)
        Locator.build(type).send(method, scope, *args)
      end
    end

    def current_scope(dom)
      dom = Locator::Dom.page(dom) unless dom.respond_to?(:elements_by_xpath)

      case (scope = scopes.pop) && scope.first
      when NilClass
        dom
      when %r(^\.?//)
        dom.element_by_xpath(scope.first)
      when String
        dom.element_by_css(scope.first)
      when Dom::Element
        scope.first.to_s
      else
        locate(dom, *scope)
      end
    end

    def scopes
      @scopes ||= []
    end

  extend(self)
end