module WatchListsHelper
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

  def watch_list_table_buttons(watch_list_id)
    [_edit_button(watch_list_id), _delete_button].to_json
  end

  private

  #TODO: Fix JavaScript escaping characters issue to use fontawesome icons on buttons.
  def _edit_button(watch_list_id)
    {
      className: "btn-info",
      # text: fontawesome_icon(name_icon_with_style: "far fa-edit", text: "Edit"),
      text: "Edit Watch List",
      attr: {
        id: "watch-list-edit-button",
        "data-form-path": edit_watch_list_path(id: watch_list_id),
        # "data-modal-title": fontawesome_icon(name_icon_with_style: "far fa-edit", text: "Edit Watch List")
        "data-modal-title": "Edit Watch List"
      }
    }
  end

  def _delete_button
    {
      # text: fontawesome_icon(name_icon_with_style: "fas fa-trash", text: "Delete"),
      text: "Delete Watch List",
      className: "btn-danger ",
      attr: { id: "watch-list-delete-button" }
    }
  end
end
