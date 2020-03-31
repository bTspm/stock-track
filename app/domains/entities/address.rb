module Entities
  class Address
    attr_reader :city,
                :country,
                :id,
                :line_1,
                :line_2,
                :state,
                :zip_code

    def initialize(args = {})
      @city = args[:city]
      @country = args[:country]
      @id = args[:id]
      @line_1 = args[:line_1]
      @line_2 = args[:line_2]
      @state = args[:state]
      @zip_code = args[:zip_code]
    end

    def self.from_db_entity(entity)
      return if entity.blank?

      Entities::Address.new(entity.attributes.with_indifferent_access)
    end

    def self.from_iex_response(response = {})
      args = {
        city: response[:city],
        country: response[:country],
        line_1: response[:address],
        line_2: response[:address2],
        state: response[:state],
        zip_code: response[:zip]
      }

      new(args)
    end
  end
end

