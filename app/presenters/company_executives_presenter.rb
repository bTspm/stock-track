class CompanyExecutivesPresenter
  include Btspm::Presenters::Presentable
  GROUPS = 4

  class Scalar < Btspm::Presenters::ScalarPresenter
    def age
      data_object.age || "N/A"
    end

    def compensation_with_currency
      return "N/A" if compensation.blank? || currency.blank?

      compensation = h.number_to_human data_object.compensation
      return compensation if currency.blank?

      "#{compensation} (#{currency.upcase})"
    end

    def since
      data_object.since || "N/A"
    end
  end

  class Enum < Btspm::Presenters::EnumPresenter
    def sorted_by_name
      sort_by(&:name)
    end
  end
end
