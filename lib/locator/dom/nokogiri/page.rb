module Locator
  module Dom
    module Nokogiri
      class Page < Element
        def initialize(html)
          super(::Nokogiri::HTML::Document.parse(html))
        end
        
        def dom
          element
        end
      end
    end
  end
end