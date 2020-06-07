module Entities
  class Quote < BaseEntity
    ATTRIBUTES = %i[change
                    change_percent
                    close
                    extended_change
                    extended_change_percent
                    extended_price
                    extended_time
                    high
                    is_us_market_open
                    latest_price
                    latest_source
                    latest_update
                    latest_volume
                    low
                    open
                    previous_close
                    previous_volume
                    volume].freeze

    attr_reader *ATTRIBUTES

    def self.from_iex_response(response)
      args = {
       change: response[:change],
       change_percent: response[:changePercent],
       close: response[:close],
       extended_change: response[:extendedChange],
       extended_change_percent: response[:extendedChangePercent],
       extended_price: response[:extendedPrice],
       extended_time: response[:extendedPriceTime]&.to_datetime,
       high: response[:high],
       is_us_market_open: response[:isUSMarketOpen],
       latest_price: response[:latestPrice],
       latest_source: response[:latestSource],
       latest_update: response[:latestUpdate]&.to_datetime,
       latest_volume: response[:latestVolume],
       low: response[:low],
       open: response[:open],
       previous_close: response[:previousClose],
       previous_volume: response[:previousVolume],
       volume: response[:volume]
      }

      new(args)
    end
  end
end
