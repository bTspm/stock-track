module WatchListsHelper
  def add_symbol_to_watch_list_button
    data_options = { container: "body", toggle: "popover", placement: "bottom" }
    html_class = "btn btn-outline-info btn-sm"

    if current_user
      html_class = "#{html_class} add-to-watch-list-popover"
      data_options.merge!(symbol: params[:symbol], path: add_to_watch_lists_watch_lists_path(symbol: params[:symbol]))
    else
      html_class = "#{html_class} add-to-watch-list-popover-for-guest"
      data_options.merge!(content: _guest_popover_content)
    end

    content = fontawesome_icon(name_icon_with_style: "far fa-star", text: "Add to Watch Lists")
    button_tag content, type: "button", class: html_class, data: data_options
  end

  def add_watch_list_title
    fontawesome_icon(name_icon_with_style: "fas fa-plus", text: "Add Watch List")
  end

  def symbol_delete_button(watch_list_id:, symbol:)
    data_attrs = {
      path: delete_symbol_watch_list_path(id: watch_list_id, symbol: symbol),
      "row-element-id": "#{symbol.gsub(".", "0")}-#{watch_list_id}",
      symbol: symbol,
      toggle: "tooltip",
      placement: "left"
    }

    content = fontawesome_icon(
      name_icon_with_style: "fas fa-minus-circle symbol-delete",
      options: { data: data_attrs, title: "Delete from Watch List" }
    )
    link_to content, "javascript:void(0)", class: "text-danger"
  end

  def watch_list_delete_edit_buttons(watch_list_id)
    content_tag(:span, class: "d.none", id: "watch-list-delete-edit-buttons") do
      concat _edit_watch_list_button(watch_list_id)
      concat _delete_watch_list_button
    end
  end

  def watch_list_information(watch_list_id)
    return render_async watch_list_path(id: watch_list_id) { render partial: "stocks/loading_card" } if watch_list_id

    content_tag(:span, "No Watch Lists, please add.")
  end

  def watch_lists_popover_content(watch_lists)
    return _no_watch_lists_popover_content unless watch_lists.any?

    watch_lists.ordered_by_name_asc.map do |watch_list|
      content_tag(:div, _add_or_delete_symbol_link(watch_list), class: "dropdown-item")
    end.join.html_safe
  end

  private

  def _add_or_delete_symbol_link(watch_list)
    formatted_symbol = params[:symbol].gsub(".", "0")

    if watch_list.in_list?(params[:symbol])
      html_class = "symbol-delete"
      icon_style = "fas"
    else
      html_class = "symbol-add"
      icon_style = "far"
    end

    link_to fontawesome_icon(name_icon_with_style: "#{icon_style} fa-star text-info", text: watch_list.name),
            "javascript:void(0)",
            class: "#{html_class} mt-3 text-secondary watch-list-id-#{watch_list.id}-#{formatted_symbol}",
            data: { "watch-list-id": watch_list.id }
  end

  def _delete_watch_list_button
    button_tag fontawesome_icon(name_icon_with_style: "fas fa-trash", text: "Delete Watch List"),
               class: "btn btn-sm btn-danger ml-2",
               id: "watch-list-delete-button",
               "data-modal-title": fontawesome_icon(name_icon_with_style: "fas fa-trash", text: "Delete Watch List"),
               type: "button"
  end

  def _edit_watch_list_button(watch_list_id)
    button_tag fontawesome_icon(name_icon_with_style: "far fa-edit", text: "Edit Watch List"),
               class: "btn btn-sm btn-info",
               id: "watch-list-edit-button",
               data: { "form-path": edit_watch_list_path(id: watch_list_id),
                       "modal-title": fontawesome_icon(name_icon_with_style: "far fa-edit", text: "Edit Watch List") },
               type: "button"
  end

  def _guest_popover_content
    content_tag :span, class: "text-center" do
      concat content_tag :div, "Login to add to watchlist", class: "mb-2"
      concat link_to "Login", sign_in_path, class: "btn btn-primary btn-sm btn-block mb-3"
    end
  end

  def _no_watch_lists_popover_content
    content_tag :span, class: "text-center" do
      concat content_tag :div, "No watchlists found, please create.", class: "mb-2"
      concat link_to add_watch_list_title,
                     watch_lists_path(for_new: true, symbol: params[:symbol]),
                     class: "btn btn-sm btn-primary btn-block"
    end
  end
end
