require 'nokogiri'

class Locator
  module Dom
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
