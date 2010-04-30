require 'core_ext/string/underscore'

module Locator
  autoload :Assertions, 'locator/assertions'
  autoload :Boolean,    'locator/boolean'
  autoload :Dom,        'locator/dom'
  autoload :Decoding,   'locator/decoding'
  autoload :Element,    'locator/element'
  autoload :Matcher,    'locator/matcher'
  autoload :Result,     'locator/result'
  autoload :Xpath,      'locator/xpath'

  extend Decoding

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
          [name.to_s.dup.underscore.to_sym, Element.const_get(name)]
        end.flatten]
      end
  end

  def scopes
    @scopes ||= []
  end

  def xpath(*args)
    type = args.shift if args.first.is_a?(Symbol)
    Locator[type].new.xpath(*args)
  end

  def all(dom, *args)
    lookup(:all, dom, *args)
  end

  def locate(dom, *args, &block)
    lookup(:locate, dom, *args, &block)
  end

  def within(*args)
    dom = dom?(args.first) ? args.shift : scopes.pop
    scopes << resolve_scope(dom, args)
    yield(scopes.last)
  end

  protected

    def lookup(method, *args, &block)
      options = Hash === args.last ? args.last : {}
      dom     = args.shift if dom?(args.first)
      type    = args.shift if args.first.is_a?(Symbol)

      scope  = resolve_scope(dom, options.delete(:within)) if options[:within]
      scope  = scope || scopes.pop || dom

      result = Locator.build(type).send(method, scope, *args)
      result = result && block_given? ? within(result) { yield(result) } : result
    end

    def resolve_scope(dom, scope)
      dom   = Locator::Dom.page(dom) unless dom.respond_to?(:elements_by_xpath)
      scope = Array(scope)

      case scope.first
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

    def dom?(arg)
      arg.is_a?(Dom::Element) || html?(arg)
    end

    def html?(arg)
      arg.is_a?(String) && arg =~ /<[^>]+>/
    end

  extend(self)
end
