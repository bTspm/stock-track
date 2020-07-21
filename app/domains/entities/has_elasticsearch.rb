module Entities
  module HasElasticsearch
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      ASSOCIATED_ATTRIBUTES = %i[address
                                 country
                                 exchange
                                 issuer_type
                                 state].freeze

      def from_es_response(response = {})
        args = _args_from_es_response(response)
        new(args)
      end

      protected

      def _after_extract_from_es(args)
        return args if args.blank?

        common_attributes = ASSOCIATED_ATTRIBUTES & self::ATTRIBUTES
        return args if common_attributes.blank?

        common_attributes.each do |attribute|
          args.merge!("#{attribute}": Entities::const_get(attribute.to_s.classify).from_es_response(args))
        end
        args.with_indifferent_access
      end

      def _args_from_es_response(response)
        args = _extract_response(response: response, key_prefix: _es_key_prefix)
        _after_extract_from_es(args)
        args
      end

      def _es_key_prefix
        _es_key_prefix_mapping["#{name.demodulize.underscore}"]
      end

      def _es_key_prefix_mapping
        {
          address: "address_",
          company: "",
          country: "country_",
          exchange: "exchange_",
          issuer_type: "issuer_type_",
          state: "state_"
        }.with_indifferent_access
      end

      private

      def _extract_response(response:, key_prefix:)
        hash = {}
        response.each { |k, v| hash[k.gsub(key_prefix, "")] = v if k.to_s.include? key_prefix }
        hash
      end
    end
  end
end
