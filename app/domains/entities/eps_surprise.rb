module Entities
  class EpsSurprise < BaseEntity
    ATTRIBUTES = %i[actual date estimate].freeze

    attr_accessor *ATTRIBUTES

    def self.from_finn_hub_response(response)
      args = {
        actual: response[:actual],
        date: response[:period].to_date,
        estimate: response[:estimate]
      }
      new(args)
    end

    def surprise
      return if estimate.blank? || actual.blank?

      actual - estimate
    end

    def surprise_percent
      surprise_value = surprise
      return nil if surprise_value.blank?

      (surprise_value / estimate.abs) * 100
    end
  end
end
