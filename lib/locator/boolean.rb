module Locator
  module Boolean
    class Terms < Array
      def and!(other)
        replace(self.dup.and(other))
      end

      def and(other)
        other.empty? ? self : And.new(self, other)
      end
      alias & and

      def or!(other)
        replace(self.dup.or(other))
      end

      def or(other)
        other.empty? ? self : Or.new(self, other)
      end
      alias | and

      def to_s
        flatten.join(Or.operator)
      end
    end

    module Accessors
      def operator=(operator); @operator = operator end
      def operator; @operator end
    end

    class And < Terms
      extend Accessors
      self.operator = ' AND '

      def initialize(lft, rgt)
        replace(Array(lft).map { |l| Array(rgt).map { |r| "#{l}#{self.class.operator}#{r}" } })
      end
    end

    class Or < Terms
      extend Accessors
      self.operator = ' OR '

      def initialize(lft, rgt)
        replace([lft, rgt])
      end
    end
  end
end
