module Entities
  class DbEntity < BaseEntity
    attr_reader :errors

    def initialize(args = nil)
      super
      @errors = args[:errors]
    end

    def self.from_db_entity(entity)
      return if entity.blank?

      args = _db_entity_args(entity)
      args[:errors] = entity.errors if entity.errors.any?
      new(args)
    end

    protected

    def self._db_entity_args(entity)
      entity.attributes.with_indifferent_access
    end
  end
end
