module Entities
  class IssuerType
    attr_reader :code,
                :id,
                :name

    def initialize(args = {})
      @code = args[:code]
      @id = args[:id]
      @name = args[:name]
    end
  end
end

