module Entities
  class Quote < BaseEntity
    ATTRIBUTES = %i[change
                    change_percent
                    close
                    close_time
                    extended_change
                    extended_change_percent
                    extended_price
                    extended_time
                    high
                    is_us_market_open
                    latest_price
                    latest_source
                    latest_time
                    latest_update
                    latest_volume
                    low
                    open
                    open_time
                    previous_close
                    previous_volume
                    volume].freeze

    attr_reader *ATTRIBUTES

    def self.from_iex_response(response)
      args = {
       change: response[:change],
       change_percent: response[:changePercent],
       close: response[:close],
       close_time: (DateTime.strptime(response[:closeTime].to_s,'%Q') if response[:openTime].present?),
       extended_change: response[:extendedChange],
       extended_change_percent: response[:extendedChangePercent],
       extended_price: response[:extendedPrice],
       extended_time: (DateTime.strptime(response[:extendedPriceTime].to_s,'%Q') if response[:openTime].present?),
       high: response[:high],
       is_us_market_open: response[:isUSMarketOpen],
       latest_price: response[:latestPrice],
       latest_source: response[:latestSource],
       latest_time: response[:latestTime]&.to_date,
       latest_update: (DateTime.strptime(response[:latestUpdate].to_s,'%Q') if response[:latestUpdate].present?),
       latest_volume: response[:latestVolume],
       low: response[:low],
       open: response[:open],
       open_time: (DateTime.strptime(response[:openTime].to_s,'%Q') if response[:openTime].present?),
       previous_close: response[:previousClose],
       previous_volume: response[:previousVolume],
       volume: response[:volume],
      }

      new(args)
    end
  end
end
