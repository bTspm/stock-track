class AddressesPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    delegate  :name, to: :country, prefix: true
    delegate  :name, to: :state, prefix: true, allow_nil: true

    def formatted
      return "N/A" if data_object.blank?

      text = ""
      text += h.content_tag(:div, line_1) if line_1.present?
      text += h.content_tag(:div, line_2) if line_2.present?
      text += _city_and_state
      text += _country_and_zip
      text.html_safe
    end

    private

    def _city_and_state
      return "" if state.blank? && city.blank?

      h.content_tag(:div, [city, state_name].compact.join(", "))
    end

    def _country_and_zip
      h.content_tag(:div, [country_name, zip_code].compact.join(", "))
    end
  end
end
