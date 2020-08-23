class WatchListStore < BaseStore
  def create_or_update(params)
    watch_list = WatchList.where(id: params[:id]).first
    params.merge!(user_id: user.id, symbols: (params[:symbols] || []))
    watch_list = WatchListBuilder.new(watch_list).build_base_entity_from_params(params)
    watch_list.save!
    Entities::WatchList.from_db_entity(watch_list.reload)
  end

  def user_watch_list_by_id(id)
    Entities::WatchList.from_db_entity(WatchList.where(id: id, user_id: user.id).first)
  end

  def user_watch_lists
    WatchList.where(user_id: user.id).map { |watch_list| Entities::WatchList.from_db_entity(watch_list) }
  end
end
