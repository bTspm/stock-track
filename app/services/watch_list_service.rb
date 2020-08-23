class WatchListService < BusinessService
  include Services
  def create_or_update(params)
    watch_list_storage.create_or_update(params)
  end

  def user_watch_list_by_id(id)
    watch_list_storage.user_watch_list_by_id(id)
  end

  def user_watch_lists
    watch_list_storage.user_watch_lists
  end
end
