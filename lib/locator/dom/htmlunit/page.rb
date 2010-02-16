module Locator
  module Dom
    module Htmlunit
      class Page < Element
        def dom
          element
        end
      end
    end
  end
end