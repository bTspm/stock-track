class StocksPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    def company
      @company ||= ::CompaniesPresenter.present(data_object.company, h)
    end

    def news
      @news ||= ::NewsPresenter.present(data_object.news, h)
    end

    def quote
      @quote ||= ::QuotePresenter.present(data_object.quote, h)
    end

    def stats
      @stats ||= ::StatsPresenter.present(data_object.stats, h)
    end

    def company_details?
      address.blank? &&
       ceo.blank? &&
       description.blank? &&
       employees.blank? &&
       website.blank?
    end

  end
end
