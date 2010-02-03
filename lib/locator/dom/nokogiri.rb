require 'nokogiri'

class Locator
  module Dom
    module Nokogiri
      autoload :Element, 'locator/dom/nokogiri/element'
      autoload :Page,    'locator/dom/nokogiri/page'
    end
  end
end
