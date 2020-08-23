module Entities
  class WatchList < BaseEntity
    include HasDbEntity

    ATTRIBUTES = %i[id name symbols].freeze
    attr_accessor *ATTRIBUTES
  end
end
