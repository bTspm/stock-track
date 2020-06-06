class NewsPresenter
  include Btspm::Presenters::Presentable
  GROUPS_NUMBER = 2

  class Scalar < Btspm::Presenters::ScalarPresenter
    include Utils

    def meta_info
      data = _source_with_fontawesome_icon
      data += " | "
      data += _datetime_with_fontawesome_icon
      data.html_safe
    end

    private

    def _datetime_with_fontawesome_icon
      h.fontawesome_icon(name_icon_with_style: "fas fa-clock text-warning", text: _posted_datetime)
    end

    def _posted_datetime
      readable_datetime(datetime: datetime)
    end

    def _source_with_fontawesome_icon
      h.fontawesome_icon(name_icon_with_style: "fas fa-user text-info", text: source)
    end
  end

  class Enum < Btspm::Presenters::EnumPresenter
    def grouped
      in_groups(GROUPS_NUMBER, false).map { |news_group| NewsPresenter.present(news_group, h) }
    end
  end
end
