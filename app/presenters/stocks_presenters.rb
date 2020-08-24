class StocksPresenters
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    delegate :security_name, :symbol, :logo_url, to: :company
    delegate :latest_price_info_amount,
             :latest_price_info_change,
             :latest_price_info_last_updated,
             :open,
             :high,
             :low,
             :volume,
             :previous_volume,
             :previous_close,
             to: :quote

    def company
      @company ||= ::CompaniesPresenter.present(data_object.company, h)
    end

    def latest_price_info_change_percent
      quote.latest_price_info_change_percent({no_wrap: true})
    end

    def quote
      @quote ||= ::QuotesPresenter.present(data_object.quote, h)
    end
  end

  class Enum < Btspm::Presenters::EnumPresenter
    delegate :issuer_type_allocation_chart_data, :sector_allocation_chart_data, to: :companies

    def companies
      @companies ||= ::CompaniesPresenter.present(data_object.map(&:company), h)
    end
  end
end
