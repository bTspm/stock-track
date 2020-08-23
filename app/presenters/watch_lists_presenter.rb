class WatchListsPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    def for_select
      [name, id, { "data-watch-list-path": h.watch_list_path(id: id) }]
    end
  end

  class Enum < Btspm::Presenters::EnumPresenter
    def selected_watch_list_id
      _ordered_by_created_at_asc.first&.id
    end

    def for_select
      _ordered_by_created_at_asc.map(&:for_select)
    end

    def new_watch_list
      Entities::WatchList.new
    end

    private

    def _ordered_by_created_at_asc
      @_ordered_by_created_at_asc ||= WatchListsPresenter.present(data_object.sort_by(&:created_at), h)
    end
  end
end
