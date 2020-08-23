module Entities
  module HasDbEntity
    attr_accessor :created_at, :errors, :updated_at

    def initialize(args = {})
      super
      @created_at = args[:created_at]
      @errors = args[:errors]
      @updated_at = args[:updated_at]
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      ASSOCIATED_ATTRIBUTES = %i[address
                                 company_executives
                                 exchange
                                 issuer_type].freeze
      COUNTRY = :country
      REGION_ATTRIBUTES = %i[country state].freeze
      STATE = :state

      def from_db_entity(entity)
        return if entity.blank?

        args = _db_entity_args(entity)
        args.merge!(
          created_at: entity.created_at,
          errors: entity.errors,
          updated_at: entity.updated_at,
        )
        new(args)
      end

      protected

      def _after_extract_args_from_db_entity(entity)
        args = _handle_region_data(entity)
        common_attributes = ASSOCIATED_ATTRIBUTES & self::ATTRIBUTES

        common_attributes.each do |attribute|
          extracted_value = _value(attribute: attribute, entity: entity)
          klass = _class_name(attribute)

          if _singular?(attribute: attribute, entity: entity)
            value = klass.from_db_entity(extracted_value)
          else
            value = extracted_value.map { |datum| klass.from_db_entity(datum) }
          end

          args.merge!("#{attribute}": value)
        end

        args
      end

      def _db_entity_args(entity)
        entity.attributes.with_indifferent_access
              .merge(_after_extract_args_from_db_entity(entity))
      end

      private

      def _class_name(attribute)
        Object.const_get("Entities::#{attribute.to_s.singularize.classify}")
      end

      def _handle_region_data(entity)
        args = HashWithIndifferentAccess.new
        attributes = REGION_ATTRIBUTES & self::ATTRIBUTES
        return args if attributes.blank?

        attributes.each do |attribute|
          klass = _class_name(attribute)
          value = if attribute == STATE
                    klass.from_code(code: entity.state, country_code: entity.country)
                  else
                    klass.from_code(entity.country)
                  end
          args.merge!("#{attribute}": value)
        end
        args
      end

      def _singular?(attribute:, entity:)
        attribute.to_s.singularize == attribute.to_s &&
          !_value_enumerable?(attribute: attribute, entity: entity)
      end

      def _value_enumerable?(attribute:, entity:)
        value = _value(attribute: attribute, entity: entity)
        [Array, ActiveRecord::Relation].any? { |klass| value.kind_of?(klass) }
      end

      def _value(attribute:, entity:)
        entity.send(attribute)
      end
    end
  end
end
