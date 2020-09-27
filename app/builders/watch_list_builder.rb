class WatchListBuilder < BaseBuilder
  def add_symbol(symbol)
    @db_entity.symbols = (@db_entity.symbols + Array.wrap(symbol)).compact.uniq
  end

  def delete_symbol(symbol)
    @db_entity.symbols = @db_entity.symbols - Array.wrap(symbol)
  end

  def set_name(name)
    @db_entity.name = name
  end

  def set_user_id(user_id)
    @db_entity.user_id = user_id
  end

  protected

  def _base_column_names
    %i[name symbols user_id].freeze
  end

  def _model_class
    WatchList
  end
end
