class ExchangeStore
  include ApiClients
  include Cacheable

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

  def create_or_update_exchanges
    exchanges_response = iex_client.exchanges
    exchanges_response.body.each do |exchange_response|
      _save_exchange(Entities::Exchange.from_iex_response(exchange_response))
    end
  end

  private

  def _save_exchange(exchange_entity)
    exchange = Exchange.where(name: exchange_entity.name).first
    exchange = ExchangeBuilder.new(exchange).build_base_entity_from_domain(exchange_entity)
    exchange.save!
    Rails.logger.info("Exchange saved: #{exchange.code}")
    Entities::Exchange.from_db_entity(exchange)
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error("Exchange save failed: #{e.record.name} with errors: #{e.message}")
    exchange = Entities::Exchange.from_db_entity(e.record)
    raise AppExceptions::RecordInvalid.new(exchange)
  end
end
