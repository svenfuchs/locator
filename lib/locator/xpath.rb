module Locator
  autoload :Boolean, 'locator/boolean'
  
  Boolean::Or.operator, Boolean::And.operator = ' | ', ''

  class Xpath < Boolean::Terms
    def initialize(name = nil, attributes = {})
      names = Array(name || '*').map { |name| xpath?(name) ? name : "//#{name}" }
      super(names)
      attributes.each { |name, value| and!(equals(name, value)) }
    end
    
    def equals(names, values)
      case values
      when TrueClass
        "[@#{names}]"
      else
        values = Array(values).map { |value| xpath?(value) ? value : "\"#{value}\"" }
        expr = Array(names).map { |name| values.map { |value| "@#{name}=#{value}" } }
        expr.empty? ? '' : '[' + expr.flatten.join(' or ') + ']'
      end
    end
    
    def matches(name, value)
      "[contains(@#{name},\"#{value}\")]"
    end
    
    def contains(value)
      "/descendant-or-self::*[contains(.,\"#{value}\")]"
    end
    
    def xpath?(string)
      string.to_s[0, 2] == '//'
    end
  end
end