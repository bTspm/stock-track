class WatchListStore < BaseStore
  def add_symbol_to_watch_list(id:, symbol:)
    watch_list = WatchList.find_by!(id: id, user_id: user.id)
    watch_list = WatchListBuilder.new(watch_list).build { |build| build.add_symbol(symbol) }
    watch_list.save!
    Entities::WatchList.from_db_entity(watch_list)
  end

  def by_id(id)
    Entities::WatchList.from_db_entity(WatchList.find_by!(id: id, user_id: user.id))
  end

  def delete(id)
    WatchList.find_by!(id: id, user_id: user.id).destroy
  end

  def delete_symbol_from_watch_list(id:, symbol:)
    watch_list = WatchList.find_by!(id: id, user_id: user.id)
    watch_list = WatchListBuilder.new(watch_list).build { |build| build.delete_symbol(symbol) }
    watch_list.save!
    Entities::WatchList.from_db_entity(watch_list)
  end

  def save_watch_list(params)
    watch_list = params[:id].blank? ? nil : WatchList.find_by!(id: params[:id], user_id: user.id)
    params.merge!(symbols: (params[:symbols] || []))
    watch_list = WatchListBuilder.new(watch_list).build_base_entity_from_params(params)
    watch_list.save!
    Entities::WatchList.from_db_entity(watch_list)
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error("Watchlist save failed: #{watch_list.id}, #{watch_list.name} with errors: #{e.message}")
    watch_list = Entities::WatchList.from_db_entity(e.record)
    raise AppExceptions::RecordInvalid.new(watch_list)
  end

  def user_watch_lists
    WatchList.where(user_id: user.id).map { |watch_list| Entities::WatchList.from_db_entity(watch_list) }
  end
end
