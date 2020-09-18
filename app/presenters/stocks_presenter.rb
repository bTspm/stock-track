class StocksPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    delegate :sector, :security_name, :symbol, to: :company
    delegate :formatted_ytd, to: :growth
    delegate :latest_price_info_amount,
             :latest_price_info_change,
             :latest_price_info_last_updated,
             :open,
             :high,
             :low,
             :formatted_volume,
             :volume,
             :previous_volume,
             :previous_close,
             to: :quote
    delegate :dividend_yield, :formatted_dividend_yield, :formatted_market_cap, :market_cap, to: :stats

    def company
      @company ||= ::CompaniesPresenter.present(data_object.company, h)
    end

    def growth
      @growth ||= ::GrowthPresenter.present(data_object.growth, h)
    end

    def latest_price_info_change_percent
      quote.latest_price_info_change_percent({ no_wrap: true })
    end

    def quote
      @quote ||= ::QuotesPresenter.present(data_object.quote, h)
    end

    def stats
      @stats ||= ::StatsPresenter.present(data_object.stats, h)
    end
  end

  class Enum < Btspm::Presenters::EnumPresenter
  end
end
