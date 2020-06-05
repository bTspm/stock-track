class CompanyExecutivesPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    include Utils

    def age
      value_or_na(data_object.age)
    end

    def compensation_with_currency
      return "N/A" if compensation.blank? && currency.blank?

      compensation = h.number_with_delimiter data_object.compensation
      return compensation if currency.blank?

      "#{compensation} (#{currency.upcase})"
    end

    def since
      value_or_na(data_object.since)
    end
  end

  class Enum < Btspm::Presenters::EnumPresenter
    def sorted_by_name
      sort_by(&:name)
    end
  end
end
