module Entities
  class CompanyExecutive
    attr_reader :age,
                :name,
                :since,
                :titles

    def initialize(args = {})
      @age = args[:age]
      @name = args[:name]
      @since = args[:since]
      @titles = args[:titles] || Array.new
    end

    def self.from_db_entity(entity)
      return new if entity.blank?
    end

    def self.from_finn_hub_response(response={})
      args = {
        age: response[:age],
        name: response[:name],
        since: response[:since],
        titles: _title_format(response[:title])
      }

      new(args)
    end

    def self._title_format(title_string)
      return Array.new if title_string.blank?

      title_string.split(',')
    end

    private_class_method :_title_format
  end
end
