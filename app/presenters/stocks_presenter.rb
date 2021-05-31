class StocksPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    delegate :sector, :security_name, :symbol, to: :company
    delegate :formatted_ytd, to: :growth
    delegate :price,
             :change,
             :change_percent,
             :updated_at,
             :open,
             :high,
             :low,
             :volume,
             :previous_close,
             to: :quote
    delegate :dividend_yield, :market_cap, to: :stats

    def company
      @company ||= ::CompaniesPresenter.present(data_object.company, h)
    end

    def growth
      @growth ||= ::GrowthPresenter.present(data_object.growth, h)
    end

    def quote
      @quote ||= ::QuotesPresenter.present(data_object.quote, h)
    end

    def stats
      @stats ||= ::StatsPresenter.present(data_object.stats, h)
    end
  end

  class Enum < Btspm::Presenters::EnumPresenter
    include Utils
  end
end
