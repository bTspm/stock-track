module Entities
  class Stock < BaseEntity
    ATTRIBUTES = %i[company quote].freeze
    attr_accessor *ATTRIBUTES
  end
end
