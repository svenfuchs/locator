require 'nokogiri'

module Locator
  module Dom
    module Htmlunit
      autoload :Element, 'locator/dom/htmlunit/element'
      autoload :Page,    'locator/dom/htmlunit/page'
    end
  end
end
