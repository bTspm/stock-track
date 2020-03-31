class EarningsPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    def chart_data
      {
        actual: _eps.map(&:actual),
        categories: _categories,
        estimated: _estimated
      }
    end

    private

    def _categories
      dates = _eps.map(&:date)
      dates += _eps_estimates.map(&:date) if _eps_estimates
      dates.map { |date| "Q#{date.quarter}<br>#{date.year.to_s}" }
    end

    def _eps
      @_eps ||= data_object[:eps].sort_by(&:date).last(4)
    end

    def _eps_last_date
      @_eps_last_date ||= _eps.last.date
    end

    def _eps_estimates
      return if data_object[:eps_estimates].blank?

      @_eps_estimates ||= data_object[:eps_estimates].select do |estimate|
        estimate.date > _eps_last_date
      end.sort_by(&:date).first(2)
    end

    def _estimated
      eps_estimates = _eps.map(&:estimate)
      return eps_estimates if _eps_estimates.blank?

      eps_estimates + _eps_estimates.map(&:average)
    end
  end
end
