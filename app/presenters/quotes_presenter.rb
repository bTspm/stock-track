class QuotesPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    include Utils

    def change_and_change_percent
      content = "#{change} (#{change_percent})".html_safe
      h.content_color_by_value(content: content, value: data_object.change)
    end

    def change
      content = h.st_number_with_delimiter data_object.change
      h.content_color_by_value(content: content, value: data_object.change)
    end

    def change_percent
      content = h.st_number_to_percentage data_object.change_percent
      h.content_color_by_value(content: content, value: data_object.change_percent)
    end

    def high
      h.st_number_to_currency data_object.high
    end

    def low
      h.st_number_to_currency data_object.low
    end

    def open
      h.st_number_to_currency data_object.open
    end

    def previous_close
      h.st_number_to_currency data_object.previous_close
    end

    def price
      h.st_number_to_currency data_object.price
    end

    def price_icon
      h.price_icon data_object.change
    end

    def source
      data_object.source.to_s.titleize
    end

    def updated_at
      "Updated #{h.readable_datetime(datetime: data_object.updated_at)}"
    end

    def volume
      h.st_number_to_human data_object.volume
    end
  end
end
