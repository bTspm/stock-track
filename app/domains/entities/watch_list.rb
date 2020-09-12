module Entities
  class WatchList < BaseEntity
    include HasDbEntity

    ATTRIBUTES = %i[id name symbols].freeze
    attr_accessor *ATTRIBUTES

    def in_list?(symbol)
      symbols.include? symbol
    end
  end
end
