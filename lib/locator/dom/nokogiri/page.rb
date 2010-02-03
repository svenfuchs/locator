module Locator
  module Dom
    module Nokogiri
      class Page
        def initialize(html)
          @dom = ::Nokogiri::HTML::Document.parse(html)
        end
        
        def element_by_id(id)
          elements_by_xpath("//*[@id='#{id}']").first
        end
        
        def elements_by_xpath(xpath)
          @dom.xpath(xpath).map { |element| Element.new(element) }
        end
      end
    end
  end
end