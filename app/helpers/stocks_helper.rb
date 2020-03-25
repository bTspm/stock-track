module StocksHelper

  def content_color_by_value(content:, value:)
    return if content.blank? || value.blank?
    return positive_content(content) if value.positive?
    return negative_content(content) if value.negative?

    content
  end

  def negative_content(content)
    content_tag :span, content, class: "text-danger"
  end

  def positive_content(content)
    content_tag :span, content, class: "text-success"
  end

  def change_and_change_pct(content:, negative: false)
    if negative
      negative_content fontawesome_icon("fas fa-arrow-down", content)
    else
      positive_content fontawesome_icon("fas fa-arrow-up", content)
    end
  end

  def badge_format(content, options = {})
    badge_color = options[:badge_color] || "badge-info"
    content_tag :div, content, class: "badge #{badge_color} #{options[:class]}"
  end
end
