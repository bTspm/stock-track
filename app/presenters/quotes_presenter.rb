class QuotesPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    include Utils

    PRICE_METHODS = %i[amount
                       change
                       change_percent
                       last_updated
                       price_color
                       price_icon
                       source].freeze
    delegate *PRICE_METHODS, to: :extended_price_info, prefix: true
    delegate *PRICE_METHODS, to: :latest_price_info, prefix: true

    def day_range
      return "N/A" if data_object.low.blank? && data_object.high.blank?

      "#{_low} - #{_high}".html_safe
    end

    def extended_price_info
      @extended_price_info ||= _extended_price_info
    end

    def latest_price_info
      @latest_price_info ||= _latest_price_info
    end

    def open
      return "N/A" if data_object.open.blank?

      h.number_with_delimiter data_object.open
    end

    def previous_close
      return "N/A" if data_object.previous_close.blank?

      h.number_with_delimiter data_object.previous_close
    end

    def previous_volume
      return "N/A" if data_object.previous_volume.blank?

      h.number_with_delimiter data_object.previous_volume
    end

    def show_extended_info?
      return false if is_us_market_open
      return false unless _has_extended_info?

      true
    end

    def volume
      return "N/A" if data_object.volume.blank?

      h.number_with_delimiter data_object.volume
    end

    private

    def _has_extended_info?
      extended_change ||
        extended_change_percent ||
        extended_price
    end

    def _high
      return "N/A" if high.blank?

      h.positive_content(h.number_with_delimiter(high))
    end

    def _latest_price_info
      latest = OpenStruct.new(
        amount: latest_price,
        change: change,
        change_percent: change_percent,
        source: latest_source,
        time: latest_update
      )
      PricePresenter.present(latest, h)
    end

    def _low
      return "N/A" if low.blank?

      h.negative_content(h.number_with_delimiter(low))
    end

    def _extended_price_info
      extended = OpenStruct.new(
        amount: extended_price,
        change: extended_change,
        change_percent: extended_change_percent,
        source: PricePresenter::EXTENDED,
        time: extended_time
      )
      PricePresenter.present(extended, h)
    end
  end
end
