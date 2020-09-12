class WatchListStore < BaseStore
  def add_symbol_to_watch_list(id:, symbol:)
    watch_list = WatchList.find_by!(id: id, user_id: user.id)
    watch_list = WatchListBuilder.new(watch_list).build { |build| build.add_symbol(symbol) }
    watch_list.save!
    Entities::WatchList.from_db_entity(watch_list)
  end

  def create_or_update(params)
    watch_list = WatchList.find_or_initialize_by(id: params[:id], user_id: user.id)
    params.merge!(symbols: (params[:symbols] || []))
    watch_list = WatchListBuilder.new(watch_list).build_base_entity_from_params(params)
    watch_list.save!
    Entities::WatchList.from_db_entity(watch_list)
  end

  def delete(id)
    WatchList.find_by(id: id, user_id: user.id)&.destroy
  end

  def delete_symbol_from_watch_list(id:, symbol:)
    watch_list = WatchList.find_by!(id: id, user_id: user.id)
    watch_list = WatchListBuilder.new(watch_list).build { |build| build.delete_symbol(symbol) }
    watch_list.save!
    Entities::WatchList.from_db_entity(watch_list.reload)
  end

  def user_watch_list_by_id(id)
    Entities::WatchList.from_db_entity(WatchList.find_by(id: id, user_id: user.id))
  end

  def user_watch_lists
    WatchList.where(user_id: user.id).map { |watch_list| Entities::WatchList.from_db_entity(watch_list) }
  end
end
