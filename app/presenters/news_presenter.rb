class NewsPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    include Utils

    def meta_info
      data = h.fontawesome_icon 'fas fa-user text-info', source
      data += " | "
      data += h.fontawesome_icon 'fas fa-clock text-warning', posted_date
      data += " | "
      data += paywall
      data.html_safe
    end

    def paywall
      info = has_paywall ? { icon_class: 'text-danger', text: 'Yes' } : { icon_class: 'text-success', text: 'No' }
      paywall_info = "Paywall: #{info[:text]}"
      h.fontawesome_icon("fas fa-wallet #{info[:icon_class]}", paywall_info)
    end

    def posted_date
      epoch_to_datetime datetime
    end
  end

  class Enum < Btspm::Presenters::EnumPresenter
    def groups_abc
      in_groups(2).map{ |news_group| NewsPresenter.present(news_group, h)  }
    end
  end
end
