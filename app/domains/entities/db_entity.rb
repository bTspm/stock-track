module Entities
  class DbEntity < BaseEntity
    def self.from_db_entity(entity)
      return if entity.blank?

      new(entity.attributes.with_indifferent_access)
    end
  end
end
