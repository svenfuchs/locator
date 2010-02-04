module Locator
  module Dom
    module Nokogiri
      class Element
        attr_reader :element, :matches

        def initialize(element)
          @element = element
          @matches = []
        end

        def <=>(other)
          to_s.length <=> other.to_s.length
        end

        def xpath
          element.path.to_s
        end

        def css_path
          element.css_path.to_s
        end
        
        def content
          element.content
        end

        def inner_html
          element.inner_html
        end

        def to_s
          element.to_s
        end

        def tag_name
          element.description.name
        end

        def ancestor_of?(other)
          other.element.ancestors.include?(element)
        end

        def attribute(name)
          element.attribute(name).to_s
        end

        def attributes(names)
          names.map { |name| attribute(name) }
        end

        def elements_by_xpath(xpath)
          element.xpath(xpath).map { |element| Element.new(element) }
        end
      end
    end
  end
end
