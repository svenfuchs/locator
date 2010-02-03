class Locator
  class Element
    class SelectOption < Element
      def initialize
        super('option', [:id, :value, :content])
      end
    end
  end
end