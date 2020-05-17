module Entities
  class BaseEntity
    def initialize(args = {})
      self.class::ATTRIBUTES.each do |attribute|
        instance_variable_set(:"@#{attribute}", args.dig(attribute))
      end
    end

    def self.from_db_entity(entity)
      return if entity.blank?

      new(entity.attributes.with_indifferent_access)
    end
  end
end
