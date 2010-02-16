require 'nokogiri'

module Locator
  module Dom
    autoload :Htmlunit, 'locator/dom/htmlunit'
    autoload :Nokogiri, 'locator/dom/nokogiri'
    
    class << self
      def adapter
        @@adapter ||= Nokogiri
      end

      def adapter=(adapter)
        @@adapter = adapter
      end

      def page(html)
        adapter::Page.new(html)
      end
    end
  end
end
