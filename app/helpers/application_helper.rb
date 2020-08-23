module ApplicationHelper
  def badge_format(content:, options: {})
    badge_color = options[:badge_color] || "badge-info"
    content_tag :span, content, class: "badge #{badge_color} #{options[:class]}"
  end

  def elements_in_single(elements)
    elements.join("<br>").html_safe
  end

  def fontawesome_icon(name_icon_with_style:, options: {}, text: nil)
    content_class = name_icon_with_style
    content_class << " #{options[:class]}" if options.key?(:class)
    options[:class] = content_class
    icon_right = options.delete(:icon_right)
    html = ""

    if icon_right
      html << text.to_s unless text.blank?
      html << " " << content_tag(:i, nil, options)
    else
      html << content_tag(:i, nil, options)
      html << " " << text.to_s unless text.blank?
    end

    html.html_safe
  end

  def show_or_hide(value)
    value.blank? ? "d-none" : ""
  end
end
