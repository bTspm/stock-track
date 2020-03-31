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

    def self.from_db_entity(entity)
      return if entity.blank?

      new(entity.attributes.with_indifferent_access)
    end

    def self.from_iex_company_response(response)
      return if response.blank?

      args = {
        name: response[:exchange]
      }
      new(args)
    end

    def self.from_iex_response(response)
      return if response.blank?

      args = {
        code: response[:exchange],
        country: response[:region],
        name: response[:description]
      }

      new(args)
    end
  end
end
