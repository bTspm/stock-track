class ExchangeStore
  def create_or_update_exchanges
    exchanges_response = _iex_client.exchanges
    exchanges_response.body.each { |exchange_response| _create_or_update_exchange(exchange_response) }
  end

  def by_id(id)
    Entities::Exchange.from_db_entity(Exchange.find(id))
  end

  def by_name(name)
    Entities::Exchange.from_db_entity(Exchange.where(name: name).first)
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

  def _iex_client
    Api::Iex::Client.new
  end
end
