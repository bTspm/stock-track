module Entities
  class Stock < BaseEntity
    ATTRIBUTES = %i[company growth quote stats].freeze
    attr_accessor *ATTRIBUTES
  end
end
