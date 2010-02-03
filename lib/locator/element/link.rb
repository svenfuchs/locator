class Locator
  class Element
    class Link < Element
      def initialize
        super('a', [:id, :content], :href => true)
      end
    end
  end
end