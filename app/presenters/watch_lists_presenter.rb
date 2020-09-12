class WatchListsPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    def add_or_delete_symbol_link(symbol)
      return h.delete_symbol_from_watch_list_link(symbol: symbol, watch_list: data_object) if in_list?(symbol)

      h.add_symbol_to_watch_list_link(symbol: symbol, watch_list: data_object)
    end

    def for_select
      [name, id, { "data-watch-list-path": h.watch_list_path(id: id) }]
    end
  end

  class Enum < Btspm::Presenters::EnumPresenter
    def for_select
      _ordered_by_created_at_asc.map(&:for_select)
    end

    def new_watch_list
      Entities::WatchList.new
    end

    def ordered_by_name_asc
      @ordered_by_name_asc ||= WatchListsPresenter.present(data_object.sort_by(&:name), h)
    end

    def selected_watch_list_id
      _ordered_by_created_at_asc.first&.id
    end

    private

    def _ordered_by_created_at_asc
      @_ordered_by_created_at_asc ||= WatchListsPresenter.present(data_object.sort_by(&:created_at), h)
    end
  end
end
