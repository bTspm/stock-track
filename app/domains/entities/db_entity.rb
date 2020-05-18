module Entities
  module DbEntity
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def from_db_entity(entity)
        return if entity.blank?

        new(entity.attributes.with_indifferent_access)
      end
    end
  end
end
