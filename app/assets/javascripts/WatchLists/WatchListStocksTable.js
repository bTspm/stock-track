const WatchListStocksTable = {
    init: function () {
        this.elements = {
            tableSelector: $("#watch-list-stocks-table"),
        };

        this.constants = {
            DIV_YIELD_ACTUAL_VALUE: 10,
            DIV_YIELD_FORMATTED_VALUE: 9,
            MARKET_CAP_ACTUAL_VALUE: 12,
            MARKET_CAP_FORMATTED_VALUE: 11
        };

        return this;
    },

    render: function (buttons) {
        WatchListStocksTable.elements.tableSelector.DataTable({
            aaSorting: [], // No Initial sort
            bInfo: true,
            buttons: {
                dom: {
                    button: {
                        tag: "button",
                        className: "btn btn-sm mb-2",
                    },
                },
                buttons: buttons,
            },
            columnDefs: [
                {
                    targets: [11],
                    orderData: [12],
                },
                {
                    targets: [9],
                    orderData: [10],
                },
                {
                    "targets": "no-sort",
                    "orderable": false,
                }
            ],
            dom: "Bfrtip",
            paging: false,
            scrollCollapse: true,
            scrollX: true,
            scrollY: "100vh",
        });
    },
};
