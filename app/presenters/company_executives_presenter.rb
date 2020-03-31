class CompanyExecutivesPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    def person_name_with_age
      return name if age.blank?

      "#{name} - #{age}"
    end
  end

  class Enum < Btspm::Presenters::EnumPresenter
    def groups
      h = {}
      grouped_by_titles = group_by { |a| a.titles }
      grouped_by_titles.each { |titles, people| titles.each do |title|
        title.strip!
        h[title] = people
      end
      }
      h.keys.sort.in_groups(4).map { |keys_set| h.with_indifferent_access.slice(*keys_set) }
    end
  end
end
