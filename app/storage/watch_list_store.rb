class WatchListStore < BaseStore
  def create_or_update(params)
    watch_list = WatchList.where(id: params[:id], user_id: user.id).first
    params.merge!(symbols: (params[:symbols] || []))
    watch_list = WatchListBuilder.new(watch_list).build_base_entity_from_params(params)
    watch_list.save!
    Entities::WatchList.from_db_entity(watch_list.reload)
  end

  def delete(id)
    WatchList.where(id: id, user_id: user.id).first&.destroy
  end

  def delete_symbol_from_watch_list(id:, symbol:)
    watch_list = WatchList.where(id: id, user_id: user.id).first
    watch_list = WatchListBuilder.new(watch_list).build { |build| build.delete_symbol(symbol) }
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
