module WatchListsHelper
  def add_watch_list_button
    button_tag fontawesome_icon(name_icon_with_style: "fas fa-plus", text: "Add Watch List"),
               class: "btn btn-sm btn-primary",
               id: "watch-list-new-button",
               data: { "form-path": new_watch_list_path,
                       "modal-title": fontawesome_icon(name_icon_with_style: "fas fa-plus", text: "Add Watch List") },
               type: "button"
  end

  def add_symbol_to_watch_list_link(symbol:, watch_list:)
    formatted_symbol = symbol.gsub(".", "0")
    link_to fontawesome_icon(name_icon_with_style: "far fa-star text-info", text: watch_list.name),
            "javascript:void(0)",
            class: "symbol-add mt-3 text-secondary watch-list-id-#{watch_list.id}-#{formatted_symbol}",
            data: { "watch-list-id": watch_list.id }
  end

  def delete_symbol_from_watch_list_link(symbol:, watch_list:)
    formatted_symbol = symbol.gsub(".", "0")
    link_to fontawesome_icon(name_icon_with_style: "fas fa-star text-info", text: watch_list.name),
            "javascript:void(0)",
            class: "symbol-delete mt-3 text-secondary watch-list-id-#{watch_list.id}-#{formatted_symbol}",
            data: { "watch-list-id": watch_list.id }
  end

  def watch_list_delete_edit_buttons(watch_list_id)
    content_tag(:span, class: "d.none", id: "watch-list-delete-edit-buttons") do
      concat _edit_watch_list_button(watch_list_id)
      concat _delete_watch_list_button
    end
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

  def watch_list_information(watch_list_id)
    return render_async watch_list_path(id: watch_list_id) { render partial: "stocks/loading_card" } if watch_list_id

    content_tag(:span, "No Watch Lists, please add.")
  end

  private

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
end
