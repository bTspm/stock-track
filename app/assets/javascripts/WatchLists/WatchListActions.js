const WatchListActions = {
    init: function () {
        this.elements = {
            deleteButton: $("#watch-list-delete-button"),
            deleteModal: $("#watch-list-delete-modal"),
            deleteSymbolButtons: $(".symbol-delete"),
            editButton: $("#watch-list-edit-button"),
            formBody: $("#watch-list-form-body"),
            formCancelButton: $("#watch-list-form-cancel-button"),
            formModal: $("#watch-list-form-modal"),
            formModalTitle: $("#watch-list-form-modal #modal-title"),
            formSaveButton: $("#watch-list-form-save-button"),
            form: $("#watch-list-form"),
            loader: $("#watch-list-form-modal #loader"),
            newButton: $("#watch-list-new-button"),
        };
        WatchListActions._bindEvents();
        return this;
    },

    _actionButtonOnClick: function () {
        WatchListActions.elements.formBody.empty();
        WatchListActions.elements.formModalTitle.empty().html($(this).data("modal-title"));
        WatchListActions.elements.formModal.modal("show");
        WatchListActions.elements.loader.removeClass("d-none");
        WatchListActions._getFormData($(this).data("form-path"));
    },

    _bindEvents: function () {
        WatchListActions.elements.editButton.off().click(WatchListActions._actionButtonOnClick);
        WatchListActions.elements.deleteButton.off().click(WatchListActions._delete);
        WatchListActions.elements.deleteSymbolButtons.each(WatchListActions._deleteSymbol);
        WatchListActions.elements.newButton.off().click(WatchListActions._actionButtonOnClick);
        WatchListActions.elements.formCancelButton.off().click(WatchListActions._hideModal);
        WatchListActions.elements.formSaveButton.off().click(WatchListActions._submit);
    },

    _delete: function () {
        WatchListActions.elements.deleteModal.modal("show");
    },

    _deleteSymbol: function () {
        $(this).off().click(function () {
            let rowElement = $('#' + $(this).data('row-element-id'));
            $.ajax({
                type: "DELETE",
                dataType: "JSON",
                url: $(this).data('path'),
            }).done(function(){
                rowElement.addClass("d-none");
                Notifications.success("Deleted from Watchlist.")
            })
        });
    },

    _getFormData: function (path) {
        $.ajax({
            type: "GET",
            dataType: "HTML",
            url: path,
        })
            .done(WatchListActions._updateFormDataOnSuccess)
            .always(WatchListActions._hideLoader);
    },

    _hideLoader: function () {
        WatchListActions.elements.loader.addClass("d-none");
    },

    _hideModal: function () {
        WatchListActions.elements.formModal.modal("hide");
    },

    _onSaveSuccess: function (data) {
        WatchListActions._hideModal();
        const watchList = WatchList.init();
        watchList.updateWatchListDropdown(data.watch_list.id);
        watchList.stocksView(data.path);
        WatchListActions.init();
    },

    _submit: function (event) {
        $.ajax({
            type: $(this).data("method"),
            data: WatchListActions.elements.form.find("input, select").serializeArray(),
            dataType: "JSON",
            url: $(this).data("path"),
        })
            .done(WatchListActions._onSaveSuccess)
            .always(WatchListActions._hideLoader);
        event.preventDefault();
        event.stopPropagation();
    },

    _updateFormDataOnSuccess: function (data) {
        WatchListActions.elements.formBody.empty().html(data);
        WatchListActions.init();
    },
};
