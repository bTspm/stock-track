const AddToWatchList = {
    init: function (symbol) {
        this.elements = {
            addSymbolClass: ".symbol-add",
            deleteSymbolClass: ".symbol-delete",
            popover: $(".add-to-watch-list-popover"),
            guestPopover: $(".add-to-watch-list-popover-for-guest"),
        };

        this.inputs = {
            formattedSymbol: symbol.replace(".", "0"),
            symbol: symbol,
        };

        AddToWatchList._bindEvents();
        return this;
    },

    render: function () {
        AddToWatchList.elements.popover.popover({
            html: true,
            content: function () {
                return AddToWatchList._watchListsLinks();
            },
        });

        AddToWatchList.elements.guestPopover.popover({
            html: true
        });
    },

    _bindEvents: function () {
        // Elements exist on a pop-over, hence had to bind element events on document.
        $(document).on(
            "click",
            AddToWatchList.elements.addSymbolClass,
            AddToWatchList._addToWatchList
        );
        $(document).on(
            "click",
            AddToWatchList.elements.deleteSymbolClass,
            AddToWatchList._deleteFromWatchList
        );
    },

    _addToWatchList: function () {
        let path =
            "/watch_lists/" +
            $(this).data("watch-list-id") +
            "/add_symbol?symbol=" +
            AddToWatchList.inputs.symbol;
        $.ajax({
            type: "PATCH",
            dataType: "JSON",
            url: path,
        })
            .done(AddToWatchList._onAddSuccess)
            .fail(AddToWatchList._onError);
    },

    _deleteFromWatchList: function () {
        let path =
            "/watch_lists/" +
            $(this).data("watch-list-id") +
            "/delete_symbol?symbol=" +
            AddToWatchList.inputs.symbol;
        $.ajax({
            type: "DELETE",
            dataType: "JSON",
            url: path,
        })
            .done(AddToWatchList._onDeleteSuccess)
            .fail(AddToWatchList._onError);
    },

    _linkElement: function (watch_list_id) {
        return $(
            ".watch-list-id-" +
            watch_list_id +
            "-" +
            AddToWatchList.inputs.formattedSymbol
        );
    },

    _onAddSuccess: function (data) {
        let linkElement = AddToWatchList._linkElement(data.watch_list_id);
        linkElement.find("i").toggleClass("far fas");
        linkElement.toggleClass("symbol-add symbol-delete");
        Notifications.success(data.message);
    },

    _onDeleteSuccess: function (data) {
        let linkElement = AddToWatchList._linkElement(data.watch_list_id);
        linkElement.find("i").toggleClass("fas far");
        linkElement.toggleClass("symbol-delete symbol-add");
        Notifications.success(data.message);
    },

    _onError: function (data) {
        Notifications.error(data.responseJSON.message);
    },

    _watchListsLinks: function () {
        $.ajax({
            type: "GET",
            dataType: "HTML",
            url:
                "/watch_lists/add_to_watch_lists?symbol=" +
                AddToWatchList.inputs.symbol,
        }).done(function (data) {
            $(".popover-body").empty().html(data);
        });
    },
};
