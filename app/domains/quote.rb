  class Quote

    attr_reader :avg_total_volume,
                :change,
                :change_percent,
                :close,
                :close_time,
                :company_name,
                :high,
                :is_us_market_open,
                :latest_price,
                :latest_source,
                :latest_time,
                :latest_update,
                :latest_volume,
                :low,
                :market_cap,
                :open,
                :open_time,
                :pe_ratio,
                :previous_close,
                :previous_volume,
                :primary_exchange,
                :symbol,
                :volume,
                :week_52_high,
                :week_52_low,
                :ytd_change

    def initialize(response = {})
      @avg_total_volume = response[:avgTotalVolume]
      @change = response[:change]
      @change_percent = response[:changePercent]
      @close = response[:close]
      @close_time = response[:closeTime]
      @company_name = response[:companyName]
      @high = response[:high]
      @is_us_market_open = response[:isUSMarketOpen]
      @latest_price = response[:latestPrice]
      @latest_source = response[:latestSource]
      @latest_time = response[:latestTime]
      @latest_update = response[:latestUpdate]
      @latest_volume = response[:latestVolume]
      @low = response[:low]
      @market_cap = response[:marketCap]
      @open = response[:open]
      @open_time = response[:openTime]
      @pe_ratio = response[:peRatio]
      @previous_close = response[:previousClose]
      @previous_volume = response[:previousVolume]
      @primary_exchange = response[:primaryExchange]
      @symbol = response[:symbol]
      @volume = response[:volume]
      @week_52_high = response[:week52High]
      @week_52_low = response[:week52Low]
      @ytd_change = response[:ytdChange]
    end
  end

