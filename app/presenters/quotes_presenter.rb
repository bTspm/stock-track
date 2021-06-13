class QuotesPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    include Utils

    def change_and_change_percent
      content = "#{change} (#{change_percent})".html_safe
      h.content_color_by_value(content: content, value: data_object_change)
    end

    def change
      content = h.st_number_with_delimiter data_object_change
      h.content_color_by_value(content: content, value: data_object_change)
    end

    def change_percent
      content = h.st_number_to_percentage data_object_change_percent
      h.content_color_by_value(content: content, value: data_object_change_percent)
    end

    def high
      h.st_number_to_currency data_object_high
    end

    def low
      h.st_number_to_currency data_object_low
    end

    def open
      h.st_number_to_currency data_object_open
    end

    def previous_close
      h.st_number_to_currency data_object_previous_close
    end

    def price
      h.st_number_to_currency data_object_price
    end

    def price_icon
      h.price_icon data_object_change
    end

    def source
      data_object_source.to_s.titleize
    end

    def updated_at
      "Updated #{h.readable_datetime(datetime: data_object_updated_at)}"
    end

    def volume
      h.st_number_to_human data_object_volume
    end
  end
end
