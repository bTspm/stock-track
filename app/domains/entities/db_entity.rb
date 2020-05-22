module Entities
  class DbEntity < BaseEntity
    def self.from_db_entity(entity)
      return if entity.blank?

      new(_db_entity_args(entity))
    end

    protected

    def self._db_entity_args(entity)
      entity.attributes
    end
  end
end
