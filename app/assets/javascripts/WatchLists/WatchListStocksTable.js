const WatchListStocksTable = {
    init: function () {
        this.elements = {
            table: $("#watch-list-stocks-table"),
            watchListActionButtons: $("#watch-list-delete-edit-buttons"),
        };

        this.constants = {
            DIV_YIELD_ACTUAL_VALUE: 11,
            DIV_YIELD_FORMATTED_VALUE: 10,
            MARKET_CAP_ACTUAL_VALUE: 13,
            MARKET_CAP_FORMATTED_VALUE: 12,
            VOLUME_ACTUAL_VALUE: 9,
            VOLUME_FORMATTED_VALUE: 8
        };

        return this;
    },

    render: function () {
        WatchListStocksTable._dataTable();
        WatchListStocksTable._addWatchListActionButtonsToTable();
    },

    _addWatchListActionButtonsToTable: function(){
        const watchListButtonsContent = WatchListStocksTable.elements.watchListActionButtons.html();
        WatchListStocksTable.elements.watchListActionButtons.empty();
        $("div.watch-list-delete-edit-buttons").html(watchListButtonsContent);
    },

    _dataTable: function(){
        WatchListStocksTable.elements.table.DataTable({
            aaSorting: [], // No Initial sort
            bInfo: true,
            columnDefs: [
                {
                    targets: [WatchListStocksTable.constants.MARKET_CAP_FORMATTED_VALUE],
                    orderData: [WatchListStocksTable.constants.MARKET_CAP_ACTUAL_VALUE],
                },
                {
                    targets: [WatchListStocksTable.constants.DIV_YIELD_FORMATTED_VALUE],
                    orderData: [WatchListStocksTable.constants.DIV_YIELD_ACTUAL_VALUE],
                },
                {
                    targets: [WatchListStocksTable.constants.VOLUME_FORMATTED_VALUE],
                    orderData: [WatchListStocksTable.constants.VOLUME_ACTUAL_VALUE],
                },
                {
                    "targets": "no-sort",
                    "orderable": false,
                }
            ],
            dom: "<'row'<'col-sm-12 col-md-6 mt-3 d-flex align-self-center watch-list-delete-edit-buttons'>"+
                "<'col-sm-12 col-md-6 mt-3'f>>" +
                "<'row'<'col-sm-12'tr>>" +
                "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>",
            paging: false,
            scrollCollapse: true,
            scrollX: true,
            scrollY: "100vh",
        });
    },
};
