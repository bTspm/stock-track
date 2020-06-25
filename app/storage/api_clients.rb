module ApiClients
  def finn_hub_client
    Api::FinnHub::Client.new
  end

  def iex_client
    Api::Iex::Client.new
  end

  def twelve_data_client
    Api::TwelveData::Client.new
  end
end
