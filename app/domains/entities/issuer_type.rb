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

    def self.from_db_entity(entity)
      return if entity.blank?

      new(entity.attributes.with_indifferent_access)
    end

    def self.from_iex_company_response(response = {})
      args = {
        code: response[:issueType]
      }

      new(args)
    end
  end
end

