class EarningsPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    def chart_data
      {
        actual: _eps_surprises.map(&:actual),
        categories: _categories,
        estimated: _estimated_earnings
      }
    end

    private

    def _categories
      dates = _eps_surprises.map(&:date)
      dates += _eps_estimates.map(&:date) if _eps_estimates
      dates.map { |date| "Q#{date.quarter}<br>#{date.year.to_s}" }
    end

    def _eps_surprises
      @_eps ||= data_object[:eps_surprises].sort_by(&:date).last(4)
    end

    def _eps_surprise_last_date
      @_eps_surprise_last_date ||= _eps_surprises.last.date
    end

    def _eps_estimates
      return if data_object[:eps_estimates].blank?

      @_eps_estimates ||= data_object[:eps_estimates].select do |estimate|
        estimate.date > _eps_surprise_last_date
      end.sort_by(&:date).first(2)
    end

    def _estimated_earnings
      estimated_earnings = _eps_surprises.map(&:estimate)
      return estimated_earnings if _eps_estimates.blank?

      estimated_earnings + _eps_estimates.map(&:average)
    end
  end
end
