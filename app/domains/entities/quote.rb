module Entities
  class Quote < BaseEntity
    ATTRIBUTES = [
      :change,
      :change_percent,
      :high,
      :price,
      :volume,
      :low,
      :open,
      :previous_close,
      :source,
      :updated_at
    ]
    TRADIER = :tradier

    attr_accessor *ATTRIBUTES

    class << self
      def from_iex_response(response)
        args = response.slice(*ATTRIBUTES).merge!(
          change_percent: response[:changePercent],
          price: response[:latestPrice],
          volume: response[:latestVolume],
          previous_close: response[:previousClose],
          source: response[:latestSource],
          updated_at: response[:latestUpdate]&.to_datetime,
        )

        new(args)
      end

      def from_tradier_response(response)
        args = response.slice(*ATTRIBUTES).merge!(
          change_percent: response[:change_percentage],
          price: response[:last],
          previous_close: response[:prevclose],
          source: TRADIER,
          updated_at: response[:trade_date]&.to_datetime,
        )

        new(args)
      end
    end
  end
end
