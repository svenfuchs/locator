module Locator
  module Decoding
    def decode_entities?
      @decode_entities ||= true
    end

    def decode_entities=(decode_entities)
      @decode_entities = decode_entities
    end

    def decode_attributes(hash)
      Hash[*hash.map { |name, value| [name, decode(value)] }.flatten]
    end

    def decode(value)
      value.is_a?(String) ? html_entities.decode(value) : value
    end
    
    protected

      def html_entities
        html_entities ||= begin
          require 'htmlentities'
          HTMLEntities.new
        end
      end
  end
end