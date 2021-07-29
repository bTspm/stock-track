const WatchListTile = (function () {
    const publicApi = {
        init: function () {
            this.elements = {
                selectDropDown: $("#watch-lists-dropdown"),
                stockTableContainer: $("#watch-list-tile-stock-table"),
            };

            return this;
        },

        render: function () {
            bindEvents();
            $(".timeago").timeago();
            $("[data-tooltip='tooltip']").tooltip();
        },
    };

    return publicApi;

    // private
    function bindEvents() {
        publicApi.elements.selectDropDown.change(watchListSelected);
    }

    function watchListSelected() {
        $.get({
            dataType: "HTML",
            url: "/watch_lists/" + $(this).val() + "/watch_list_stocks_for_tile",
        }).done(function (html) {
            publicApi.elements.stockTableContainer.empty().html(html);
            WatchListTile.init().render();
        });
    }
})();
