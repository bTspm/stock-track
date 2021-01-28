class ExchangeStore
  include Cacheable

  def by_code(code)
    fetch_cached(key: "#{self.class.name}/#{__method__}/#{code}") do
      Entities::Exchange.from_db_entity(Exchange.find_by(code: code))
    end
  end

  def by_id(id)
    fetch_cached(key: "#{self.class.name}/#{__method__}/#{id}") do
      Entities::Exchange.from_db_entity(Exchange.find(id))
    end
  end

  def by_name(name)
    fetch_cached(key: "#{self.class.name}/#{__method__}/#{name}") do
      Entities::Exchange.from_db_entity(Exchange.find_by(name: name))
    end
  end

  def save_exchanges
    exchanges_response = Allocator.iex_client.exchanges
    exchanges_response.body.each do |exchange_response|
      entity = Entities::Exchange.from_iex_response(exchange_response)
      _save_exchange(entity) if entity.country_usa?
    end
  end

  private

  def _save_exchange(exchange_entity)
    exchange = Exchange.find_by(code: exchange_entity.code)
    exchange = ExchangeBuilder.new(exchange).build_full_exchange_from_domain(exchange_entity)
    exchange.save!
    Rails.logger.info("Exchange saved: #{exchange.code}")
    Entities::Exchange.from_db_entity(exchange)
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error("Exchange save failed: #{e.record.name} with errors: #{e.message}")
    exchange = Entities::Exchange.from_db_entity(e.record)
    raise AppExceptions::RecordInvalid.new(exchange)
  end
end
