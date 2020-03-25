module Entities
  class Exchange
    attr_reader :code,
                :country,
                :id,
                :name

    def initialize(args = {})
      @code = args[:code]
      @country = args[:country]
      @id = args[:id]
      @name = args[:name]
    end
  end
end
