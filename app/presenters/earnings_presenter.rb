class EarningsPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    def chart_data
      {actual: _eps.actuals, categories: _categories, estimated: _estimated}
    end

    private

    def _categories
      dates = _eps.dates
      dates += _eps_estimates.dates if _eps_estimates
      dates.map { |date| "Q#{date.quarter}<br>#{date.year.to_s}" }
    end

    def _eps
      @_eps ||= EpsPresenter.present(data_object[:eps], h)
    end

    def _eps_estimates
      return if data_object[:eps_estimates].blank?

      @_eps_estimates ||= EpsEstimatesPresenter.present(data_object[:eps_estimates], h)
    end

    def _estimated
      eps_estimates = _eps.estimates
      return eps_estimates if _eps_estimates.blank?

      eps_estimates + _eps_estimates.estimates
    end
  end
end
