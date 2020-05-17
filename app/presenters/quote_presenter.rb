class QuotePresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    include Utils

    def day_range
      return "N/A" if data_object.low.blank? && data_object.high.blank?

      "#{low} - #{high}".html_safe
    end

    def latest_price_info
      latest = OpenStruct.new(
       amount: latest_price,
       change: change,
       change_percent: change_percent,
       source: latest_source,
       time: latest_update
      )
      PricePresenter.present(latest, h)
    end

    def extended_price_info
      extended = OpenStruct.new(
       amount: extended_price,
       change: extended_change,
       change_percent: extended_change_percent,
       source: PricePresenter::EXTENDED,
       time: extended_time
      )
      PricePresenter.present(extended, h)
    end

    def high
      h.positive_content(h.number_with_delimiter(data_object.high))
    end

    def low
      h.negative_content(h.number_with_delimiter(data_object.low))
    end

    def open
      return "N/A" if data_object.open.blank?

      h.number_with_delimiter data_object.open
    end

    def previous_close
      return "N/A" if data_object.previous_close.blank?

      h.number_with_delimiter data_object.previous_close
    end

    def volume
      return "N/A" if data_object.volume.blank?
      h.number_with_delimiter data_object.volume
    end

    def show_extended_info?
      return false if is_us_market_open
      return false if extended_change.blank? || extended_change_percent.blank?

      true
    end

    private

    def _formatted_change_with_pct(change:, pct:)
      content = "#{h.number_with_delimiter change} (#{format_percentage(pct)})"
      return content if change.blank?

      h.change_and_change_pct(content: content, negative: change < 0)
    end
  end
end
