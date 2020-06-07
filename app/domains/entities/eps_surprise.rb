module Entities
  class EpsSurprise < BaseEntity
    ATTRIBUTES = %i[actual date estimate].freeze

    attr_reader *ATTRIBUTES

    def self.from_finn_hub_response(response)
      args = { actual: response[:actual], date: response[:period].to_date, estimate: response[:estimate] }
      new(args)
    end
  end
end
