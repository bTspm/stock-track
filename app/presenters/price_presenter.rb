class PricePresenter
  include Btspm::Presenters::Presentable
  EXTENDED = "Extended".freeze
  EXTENDED_BADGE = "badge-warning".freeze
  NOT_EXTENDED_BADGE = "badge-info".freeze

  class Scalar < Btspm::Presenters::ScalarPresenter
    include Utils

    def amount
      h.number_with_delimiter data_object.amount
    end

    def change
      content = h.number_with_delimiter data_object.change
      h.content_color_by_value(content: content, value: data_object.change)
    end

    def change_percent(options={})
      content = format_percentage(data_object.change_percent)
      content = "(#{content})" unless options[:no_wrap]
      h.content_color_by_value(content: content, value: data_object.change_percent)
    end

    def last_updated
      h.readable_datetime(datetime: data_object.time)
    end

    def price_color
      h.price_color_class data_object.change
    end

    def price_icon
      h.price_icon data_object.change
    end

    def source
      badge_color = _extended? ? EXTENDED_BADGE : NOT_EXTENDED_BADGE
      h.badge_format(content: data_object.source, options: { badge_color: badge_color })
    end

    private

    def _extended?
      data_object.source == PricePresenter::EXTENDED
    end
  end
end
