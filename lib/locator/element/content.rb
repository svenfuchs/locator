module Locator
  class Element
    class Content < Element
      def initialize(*args)
        super
        locatables.delete(:id)
      end
    end
  end
end