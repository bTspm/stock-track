module Elasticsearch
  module Searchable
    ADD = "add".freeze
    REMOVE = "remove".freeze

    def add_alias(index_names)
      _alias_actions(action: ADD, index_names: index_names)
    end

    def all_indices_by_alias
      _client.indices.get_alias.keys.select{ |x| x.include?(_index_alias) }
    end

    def bulk_index(body)
      response = _client.bulk({ body: body })
      Rails.logger.error("[ElasticSearch] Failed to bulk #{response.to_s}") if response["errors"]
      response.with_indifferent_access
    end

    def create_index(index_name = nil)
      index_name ||= _new_index_name
      args = { body: _mappings_and_settings, index: index_name }
      _client.indices.create(args)
      add_alias(index_name)
    rescue StandardError => e
      Rails.logger.error("Index creation failed - #{index_name} with error - #{e.message}")
    end

    def delete_index(name)
      _client.indices.delete({ index: name }) rescue nil
    end

    def delete_all_indices_by_alias
      delete_index(all_indices_by_alias)
    end

    def indices_list
      _client.indices.get({ index: "_all" })
    end

    def reindex(source)
      destination = _new_index_name
      args = { body: { source: { index: source }, dest: { index: destination } }, wait_for_completion: false }
      _client.reindex(args)
    end

    def remove_alias(index_names)
      _alias_actions(action: REMOVE, index_names: index_names)
    end

    def search(query:, options: {})
      index = options.dig(:index) || _index_alias
      size = options.dig(:size) || _default_limit
      payload = { index: index, size: size, body: query }
      response = _client.search(payload)
      return response if options[:return_raw]

      response["hits"]["hits"].map { |datum| datum["_source"] }
    end

    protected

    def _client
      @_client ||= Allocator.company_index_client
    end

    def _default_limit
      50
    end

    def _index_alias
      "companies"
    end

    def _mappings_and_settings
      YAML.load_file(File.join(_indices_path, "companies-mappings-settings.yml"))
    end

    private

    def _alias_actions(action:, index_names:)
      index_names = Array.wrap(index_names)
      actions = index_names.map { |index_name| { "#{action}": { index: index_name, alias: _index_alias } } }
      _client.indices.update_aliases(body: { actions: actions })
    end

    def _indices_path
      "#{Rails.root}/app/models/concerns/elasticsearch"
    end

    def _new_index_name
      "#{_index_alias}-#{Time.now.to_i}"
    end

    def _index_bulk_payload(data:, id:)
      { index: { _index: _index_alias, _id: id, data: data, } }
    end
  end
end
