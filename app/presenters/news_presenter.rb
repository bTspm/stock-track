class NewsPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    include Utils

    def meta_info
      data = h.fontawesome_icon 'fas fa-user text-info', source
      data += " | "
      data += h.fontawesome_icon 'fas fa-clock text-warning', posted_date
      data.html_safe
    end

    def posted_date
      readable_date datetime, "%b %d, %Y %-l:%M:%S %p"
    end
  end

  class Enum < Btspm::Presenters::EnumPresenter
    def groups_abc
      in_groups(2).map { |news_group| NewsPresenter.present(news_group, h) }
    end
  end
end
