module Locator
  module Dom
    module Htmlunit
      class Element
        attr_reader :element, :matches

        def initialize(element)
          @element = element || raise('nil passed as an element')
          @matches = []
        end

        def <=>(other)
          to_s.length <=> other.to_s.length
        end

        def name
          element.getNodeName
        end

        def xpath
          element.getCanonicalXPath
        end

        def css_path
          raise 'not implemented'
        end
        
        def content
          # TODO HtmlUnit has asText and getTextContent
          element.getTextContent # Celerity normalizes this
        end
        
        # def inner_html
        #   element.inner_html
        # end
        
        def to_s
          element.asXml
        end
        
        def attribute(name)
          element.getAttribute(name)
        end
        
        def element_by_id(id)
          element_by_xpath("//*[@id='#{id}']")
        end

        def element_by_xpath(xpath)
          if element = self.element.getFirstByXPath(xpath)
            Element.new(element)
          end
        end
        
        def elements_by_xpath(*xpaths)
          xpaths.map do |xpath| 
            element.getByXPath(xpath).toArray.map { |e| Element.new(e) }
          end.flatten
        end

        def elements_by_css(*rules)
          elements_by_xpath(*::Nokogiri::CSS.xpath_for(*rules))
        end

        def ancestors
          ancestors, node = [], element.getParentNode
          until node.getNodeName == '#document'
            ancestors.unshift(Element.new(node))
            node = node.getParentNode
          end
          ancestors
        end
        
        def ancestor_of?(other)
          other.element.ancestors.include?(element)
        end
      end
    end
  end
end
