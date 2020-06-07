module Entities
  class CompanyExecutive < DbEntity
    BASE_ATTRIBUTES = %i[age
                         compensation
                         currency
                         name
                         since
                         titles].freeze
    ATTRIBUTES = BASE_ATTRIBUTES

    attr_reader *ATTRIBUTES

    def initialize(args = {})
      super
      @titles ||= []
    end

    def self.from_finn_hub_response(response = {})
      args = {
       age: response[:age],
       compensation: response[:compensation],
       currency: response[:currency],
       name: response[:name],
       since: response[:since],
       titles: _title_format(response[:position])
      }

      new(args)
    end

    def self._title_format(title_string)
      return [] if title_string.blank?

      title_string.split(",").map(&:strip)
    end

    private_class_method :_title_format
  end
end
