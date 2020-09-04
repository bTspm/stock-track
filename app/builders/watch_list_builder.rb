class WatchListBuilder < BaseBuilder
  def delete_symbol(symbol)
    @db_entity.symbols = @db_entity.symbols - Array.wrap(symbol)
  end

  protected

  def _base_column_names
    %i[name symbols user_id].freeze
  end

  def _model_class
    WatchList
  end
end
