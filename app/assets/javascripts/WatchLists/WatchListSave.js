const WatchListSave = {
    init: function () {
        this.elements = {
            editButton: $("#watch-list-edit-button"),
            deleteButton: $("#watch-list-delete-button"),
            deleteModal: $("#watch-list-delete-modal"),
            formCancelButton: $("#watch-list-form-cancel-button"),
            formSaveButton: $("#watch-list-form-save-button"),
            newButton: $("#watch-list-new-button"),
            modal: $("#watch-list-form-modal"),
            modalTitle: $("#watch-list-form-modal #modal-title"),
            formBody: $("#watch-list-form-body"),
            form: $("#watch-list-form"),
            loader: $("#watch-list-form-modal #loader"),
        };
        WatchListSave._bindEvents();
        return this;
    },

    _actionButtonOnClick: function () {
        WatchListSave.elements.formBody.empty();
        WatchListSave.elements.modalTitle.empty().html($(this).data("modal-title"));
        WatchListSave.elements.modal.modal("show");
        WatchListSave.elements.loader.removeClass("d-none");
        WatchListSave._getFormData($(this).data("form-path"));
    },

    _bindEvents: function () {
        WatchListSave.elements.editButton
            .off()
            .click(WatchListSave._actionButtonOnClick);
        WatchListSave.elements.deleteButton
            .off()
            .click(WatchListSave._deleteButtonClick);
        WatchListSave.elements.newButton
            .off()
            .click(WatchListSave._actionButtonOnClick);
        WatchListSave.elements.formCancelButton
            .off()
            .click(WatchListSave._hideModal);
        WatchListSave.elements.formSaveButton.off().click(WatchListSave._submit);
    },

    _deleteButtonClick: function(){
        WatchListSave.elements.deleteModal.modal("show");
    },

    _getFormData: function (path) {
        $.ajax({
            type: "GET",
            dataType: "HTML",
            url: path,
        })
            .done(WatchListSave._updateFormDataOnSuccess)
            .always(WatchListSave._hideLoader);
    },

    _hideLoader: function () {
        WatchListSave.elements.loader.addClass("d-none");
    },

    _hideModal: function () {
        WatchListSave.elements.modal.modal("hide");
    },

    _onSaveSuccess: function (data) {
        WatchListSave._hideModal();
        const watchList = WatchList.init();
        watchList.updateWatchListDropdown(data.watch_list.id);
        watchList.stocksView(data.path);
        WatchListSave.init();
    },

    _submit: function (event) {
        $.ajax({
            type: $(this).data("method"),
            data: WatchListSave.elements.form.find("input, select").serializeArray(),
            dataType: "JSON",
            url: $(this).data("path"),
        })
            .done(WatchListSave._onSaveSuccess)
            .always(WatchListSave._hideLoader);
        event.preventDefault();
        event.stopPropagation();
    },

    _updateFormDataOnSuccess: function (data) {
        WatchListSave.elements.formBody.empty().html(data);
        WatchListSave.init();
    },
};
