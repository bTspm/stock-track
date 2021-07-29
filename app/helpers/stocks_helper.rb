module StocksHelper
  def stock_information_link_with_company_name(company)
    content = tooltip_wrapper company.security_name do
      content_tag(:div, company.security_name, class: "ellipsis")
    end
    link = link_to company.symbol, stocks_information_path(symbol: company.symbol), class: "font-weight-bold"

    content_tag(:span) do
      concat content_tag(:span, link)
      concat content
    end
  end

  def price_icon(value)
    icon_class = value.negative? ? "fas fa-arrow-alt-circle-down" : "fas fa-arrow-alt-circle-up"
    content = fontawesome_icon(name_icon_with_style: icon_class)
    content_color_by_value(content: content, value: value)
  end

  def section_row(label:, symbols:)
    rows = []
    rows << content_tag(:td, label)
    symbols.each do |symbol|
      link = link_to(symbol, stocks_information_path(symbol: symbol), class: "text-white")
      rows << content_tag(:td, link, class: "text-center")
    end
    content_tag(:tr, rows.join.html_safe, class: "bg-secondary text-uppercase text-white font-weight-bold")
  end

  def data_row(label:, values:, winner_index:)
    rows = []
    rows << content_tag(:td, label, class: "font-weight-bold")
    values.each_with_index do |value, index|
      html_class = "text-center"
      html_class += " row-winner" if index == winner_index
      rows << content_tag(:td, value, class: html_class)
    end
    content_tag(:tr, rows.join.html_safe)
  end
end
