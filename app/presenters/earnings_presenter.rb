class EarningsPresenter
  include Btspm::Presenters::Presentable
  ESTIMATES_COUNT = 2
  SURPRISES_COUNT = 4

  class Scalar < Btspm::Presenters::ScalarPresenter
    def chart_data
      { actual: _actual, categories: _categories, estimated: _estimated_earnings }.to_json
    end

    private

    def _actual
      _eps_surprises.map { |surprise| surprise.actual&.round(2) }
    end

    def _categories
      dates = _eps_surprises.map(&:date)
      dates += _eps_estimates.map(&:date) if _eps_estimates
      dates.map { |date| "Q#{date.quarter}<br>#{date.year}" }
    end

    def _eps_estimates
      return if data_object[:eps_estimates].blank?

      @_eps_estimates ||= data_object[:eps_estimates].select do |estimate|
        estimate.date > _eps_surprise_last_date
      end.sort_by(&:date).first(ESTIMATES_COUNT)
    end

    def _eps_surprises
      @_eps_surprises ||= data_object[:eps_surprises].sort_by(&:date).last(SURPRISES_COUNT)
    end

    def _eps_surprise_last_date
      @_eps_surprise_last_date ||= _eps_surprises.last.date
    end

    def _estimated_earnings
      estimated_earnings = _eps_surprises.map { |surprise| surprise.estimate.round(2) }
      return estimated_earnings if _eps_estimates.blank?

      estimated_earnings + _eps_estimates.map { |estimate| estimate.average.round(2) }
    end
  end
end
