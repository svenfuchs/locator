class Locator
  class Element
    class Label < Element
      def initialize
        super('label', [:id, :content])
      end
    end
  end
end
