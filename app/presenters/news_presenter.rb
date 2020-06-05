class NewsPresenter
  include Btspm::Presenters::Presentable
  GROUPS_NUMBER = 2

  class Scalar < Btspm::Presenters::ScalarPresenter
    include Utils

    def meta_info
      data = h.fontawesome_icon "fas fa-user text-info", source
      data += " | "
      data += h.fontawesome_icon "fas fa-clock text-warning", _posted_datetime
      data.html_safe
    end

    private

    def _posted_datetime
      readable_datetime(datetime: datetime)
    end
  end

  class Enum < Btspm::Presenters::EnumPresenter
    def grouped
      in_groups(GROUPS_NUMBER, false).map { |news_group| NewsPresenter.present(news_group, h) }
    end
  end
end
