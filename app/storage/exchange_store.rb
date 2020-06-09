class ExchangeStore
  include Allocator::ApiClients
  include Cacheable

  def create_or_update_exchanges
    exchanges_response = iex_client.exchanges
    exchanges_response.body.each { |exchange_response| _create_or_update_exchange(exchange_response) }
  end

  def by_id(id)
    fetch_cached(key: "#{self.class.name}/#{__method__}/#{id}") do
      Entities::Exchange.from_db_entity(Exchange.find(id))
    end
  end

  def by_name(name)
    fetch_cached(key: "#{self.class.name}/#{__method__}/#{name}") do
      Entities::Exchange.from_db_entity(Exchange.where(name: name).first)
    end
  end

  private

  def _create_or_update_exchange(response)
    exchange_entity = Entities::Exchange.from_iex_response(response)
    ::Exchange.where(name: exchange_entity.name).first_or_initialize.tap do |exchange|
      exchange.code = exchange_entity.code
      exchange.country = exchange_entity.country
      exchange.save
    end
  end
end
