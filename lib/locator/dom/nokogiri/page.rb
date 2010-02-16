module Locator
  module Dom
    module Nokogiri
      class Page < Element
        def initialize(dom)
          dom = ::Nokogiri::HTML::Document.parse(dom) if dom.is_a?(String)
          super
        end
        
        def dom
          element
        end
      end
    end
  end
end