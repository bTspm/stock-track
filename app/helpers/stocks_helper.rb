module StocksHelper
  def content_color_by_value(content: nil, value:)
    content ||= value
    return negative_content(content) if value.negative?
    return positive_content(content) if value.positive?

    content
  end

  def negative_content(content)
    content_tag :span, content, class: "text-danger"
  end

  def positive_content(content)
    content_tag :span, content, class: "text-success"
  end

  def price_color_class(value)
    return "loss" if value.negative?
    return "profit" if value.positive?

    ""
  end

  def price_icon(value)
    icon_class = value.negative? ? "fas fa-arrow-alt-circle-down" : "fas fa-arrow-alt-circle-up"
    content = fontawesome_icon(name_icon_with_style: icon_class)
    content_color_by_value(content: content, value: value)
  end
end
