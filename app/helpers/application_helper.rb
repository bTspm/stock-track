module ApplicationHelper
  DEFAULT_DATE_FORMAT = "%b %d, %Y".freeze
  DEFAULT_DATETIME_FORMAT = "%b %d, %Y %-l:%M:%S %p".freeze
  DEFAULT_TIME_ZONE = "Eastern Time (US & Canada)".freeze

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

  def readable_datetime(datetime:, format: DEFAULT_DATETIME_FORMAT)
    return "N/A" if datetime.blank?

    datetime.in_time_zone(DEFAULT_TIME_ZONE).strftime(format)
  end

  def readable_date(date:, format: DEFAULT_DATE_FORMAT)
    date.blank? ? "N/A" : date.strftime(format)
  end

  def show_or_hide(value)
    value.blank? ? "d-none" : ""
  end

  def time_ago(datetime)
    content_tag :span, readable_datetime(datetime: datetime), class: "timeago", title: datetime
  end

  def tooltip_wrapper(title, &block)
    content_tag :span, title: title, data: { tooltip: :tooltip } do
      block.call
    end
  end
end
