class AddressesPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    delegate  :code, to: :country, prefix: true
    delegate  :name, to: :state, prefix: true, allow_nil: true

    def formatted
      return "N/A" if data_object.blank?

      text = ""
      text += h.content_tag(:div, line_1) if line_1.present?
      text += h.content_tag(:div, line_2) if line_2.present?
      text += _city_state_country_and_zip
      text.html_safe
    end

    private

    def _city_state_country_and_zip
      return "" if state.blank? && country.blank? && zip_code.blank?

      address = [city, state_name, country_code, zip_code].compact.join(", ")
      h.content_tag(:div, address)
    end
  end
end
