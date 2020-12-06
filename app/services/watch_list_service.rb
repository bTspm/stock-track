class WatchListService < BusinessService
  include Services
  def add_symbol_to_watch_list(id:, symbol:)
    watch_list_storage.add_symbol_to_watch_list(id: id, symbol: symbol)
  end

  def delete_symbol_from_watch_list(id:, symbol:)
    watch_list_storage.delete_symbol_from_watch_list(id: id, symbol: symbol)
  end

  def delete_watch_list(id)
    watch_list_storage.delete(id)
  end

  def save_watch_list(params)
    watch_list_storage.save_watch_list(params)
  end

  def watch_list_by_id(id)
    watch_list_storage.by_id(id)
  end

  def user_watch_lists
    watch_list_storage.user_watch_lists
  end
end
