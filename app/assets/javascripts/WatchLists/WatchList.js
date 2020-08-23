const WatchList = {
    init: function () {
        this.elements = {
            loader: $("#loader"),
            selectDropdown: $("#watch-lists-dropdown"),
            selectDropdownContainer: $("#watch-lists-dropdown-container"),
            watchListInformation: $("#watch-list-information")
        };
        WatchList._bindEvents();
        return this;
    },

    stocksView: function (path) {
        WatchList.elements.watchListInformation.empty();
        WatchList._showLoader();
        $.ajax({
            type: "GET",
            dataType: 'HTML',
            url: path,
        }).done(function (data) {
            WatchList.elements.watchListInformation.html(data)
        }).always(WatchList._hideLoader)
    },

    updateWatchListDropdown: function (id) {
        $.ajax({
            type: "GET",
            dataType: 'HTML',
            url: "watch_lists/update_dropdown?selected_id=" + id,
        }).done(function (data) {
            WatchList.elements.selectDropdownContainer.empty().html(data);
            WatchList.init();
        })
    },

    _bindEvents: function () {
        WatchList._initDropdown();
        WatchList._onSelection();
        WatchListSave.init();
    },

    _hideLoader: function () {
        WatchList.elements.loader.addClass("d-none")
    },

    _initDropdown: function () {
        WatchList.elements.selectDropdown.select2({
            width: "resolve",
            theme: "bootstrap"
        });
    },

    _onSelection: function () {
        WatchList.elements.selectDropdown.on('select2:select', function (e) {
            WatchList.elements.watchListInformation.empty();
            $("#loader").removeClass("d-none")
            WatchList.stocksView($(e.params.data.element).data("watch-list-path"))
        });
    },

    _showLoader: function () {
        WatchList.elements.loader.removeClass("d-none")
    },
};
