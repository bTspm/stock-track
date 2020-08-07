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
        common_attributes.each do |attribute|
          args.merge!("#{attribute}": Object.const_get("Entities::#{attribute.to_s.classify}").from_es_response(args))
        end
        args.with_indifferent_access
      end

      def _args_from_es_response(response)
        args = _extract_response(response)
        _after_extract_from_es(args)
        args
      end

      private

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

      def _extract_response(response)
        hash = {}
        key_prefix = _es_key_prefix_mapping["#{name.demodulize.underscore}"]
        response.each { |k, v| hash[k.to_s.gsub(key_prefix, "")] = v if k.to_s.include? key_prefix }
        hash
      end
    end
  end
end
