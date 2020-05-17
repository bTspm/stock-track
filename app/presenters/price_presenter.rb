class PricePresenter
  include Btspm::Presenters::Presentable
  EXTENDED = "Extended".freeze

  class Scalar < Btspm::Presenters::ScalarPresenter
    include Utils

    def change
      content = h.number_with_delimiter data_object.change
      h.content_color_by_value(content: content, value: data_object.change)
    end

    def change_percent
      content = format_percentage(data_object.change_percent)
      h.content_color_by_value(content: "(#{content})", value: data_object.change_percent)
    end

    def last_updated
      readable_date(data_object.time, "%b %d, %Y %-l:%M:%S %p")
    end

    def price_color
      h.price_color_class data_object.change
    end

    def amount
      h.number_with_delimiter data_object.amount
    end

    def change_amount_with_percentage
      change + change_percent
    end

    def price_icon
      h.price_icon data_object.change
    end

    def source
      badge_color = extended? ? "badge-warning" : "badge-info"
      h.badge_format(data_object.source, {badge_color: badge_color})
    end

    private

    def extended?
      data_object.source == PricePresenter::EXTENDED
    end
  end
end
