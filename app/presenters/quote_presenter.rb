class QuotePresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    include Utils

    def day_range
      return "N/A" if data_object.low.blank? && data_object.high.blank?

      "#{low} - #{high}".html_safe
    end

    def high
      h.positive_content(h.number_with_delimiter(data_object.high))
    end

    def low
      h.negative_content(h.number_with_delimiter(data_object.low))
    end

    def change_percent
      h.content_color_by_value(
        content: format_percentage(data_object.change_percent),
        value: data_object.change_percent
      )
    end

    def latest_price_icon
      icon_class = if data_object.change.positive?
                     "fas fa-arrow-alt-circle-up"
                   elsif data_object.change.negative?
                    "fas fa-arrow-alt-circle-down"
                   else
                     "fas fa-arrow-alt-circle-up"
                   end

      content = h.fontawesome_icon(icon_class)
      h.content_color_by_value(content: content, value: data_object.change)
    end

    def latest_price
      h.number_with_delimiter data_object.latest_price
    end

    def change
      h.content_color_by_value(content: h.number_with_delimiter(data_object.change), value: data_object.change)
    end

    def ext_time
      epoch_to_datetime(extended_price_time)
    end

    def latest_time
      epoch_to_datetime(latest_update)
    end

    def market_status
      info = if is_us_market_open
               {icon_with_class: 'fas fa-unlock text-success', text: 'Market Open'}
             else
               {icon_with_class: 'fas fa-lock text-warning', text: 'Market Closed'}
             end
      h.fontawesome_icon(info[:icon_with_class], info[:text])
    end

    def open
      return "N/A" if data_object.open.blank?
      h.number_with_delimiter data_object.open
    end

    def previous_close
      return "N/A" if data_object.previous_close.blank?
      h.number_with_delimiter data_object.previous_close
    end

    def symbol_with_exchange_name(exchange_name)
      "#{symbol} - #{exchange_name}"
    end

    def volume
      return "N/A" if data_object.volume.blank?
      h.number_to_human data_object.volume, precision: 3
    end

    def week_52_range
      return "N/A" if week_52_low.blank? && week_52_high.blank?
      "#{week_52_low} - #{week_52_high}".html_safe
    end

    def week_52_high
      h.positive_content(h.number_with_delimiter(data_object.week_52_high))
    end

    def week_52_low
      h.negative_content(h.number_with_delimiter(data_object.week_52_low))
    end

    private

    def _formatted_change_with_pct(change:, pct:)
      content = "#{h.number_with_delimiter change} (#{format_percentage(pct)})"
      return content if change.blank?
      h.change_and_change_pct(content: content, negative: change < 0)
    end
  end
end
