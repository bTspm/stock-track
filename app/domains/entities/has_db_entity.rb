module Entities
  module HasDbEntity
    attr_reader :errors

    def initialize(args = {})
      super
      @errors = args[:errors]
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      ASSOCIATED_ATTRIBUTES = %i[address exchange issuer_type]

      def from_db_entity(entity)
        return if entity.blank?

        args = _db_entity_args(entity)
        args[:errors] = entity.errors if entity.errors.any?
        new(args)
      end

      protected

      def _after_extract_args_from_db_entity(entity)
        args = {}
        common_attributes = ASSOCIATED_ATTRIBUTES & self::ATTRIBUTES
        return args if common_attributes.blank?

        common_attributes.each do |attribute|
          value = Entities::const_get(attribute.to_s.classify).from_db_entity(entity.send(attribute))
          args.merge!("#{attribute}": value)
        end

        args.with_indifferent_access
      end

      def _db_entity_args(entity)
        args = entity.attributes.with_indifferent_access
        args.merge(_after_extract_args_from_db_entity(entity))
      end
    end
  end
end
