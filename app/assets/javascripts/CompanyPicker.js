var CompanyPicker = {

    init: function () {
        this.elements = {
            selector: $("#company-select")
        }

        this.options = {
            placeholder: 'Search Symbol',
            minimumInputLength: 1
        };

        return this;
    },

    render: function () {
        CompanyPicker.elements.selector.select2({
            multiple: true,
            width: "100%",
            ajax: {
                url: "/search/search_for_dropdown",
                data: function (params) {
                    return {
                        query: params.term // search term
                    };
                },
                dataType: 'json',
                processResults: CompanyPicker._processResults
            },
            templateResult: CompanyPicker._templateResult,
            templateSelection: CompanyPicker._templateSelection,
            placeholder: CompanyPicker.options.placeholder,
            minimumInputLength: CompanyPicker.options.minimumInputLength
        })
    },

    _templateResult: function(company){
        if (!company.id) {
            return company.text;
        }
        return $(
            "<div class='row'>" +
            "<div class='col-2 ml-1'>" + company.id + '</div>' +
            "<div class='col-9'>" + company.text + '</div>' +
            "</div>"
        );
    },

    _templateSelection: function(company){
        return company.id
    },

    _processResults: function (data) {
        return {
            results: $.map(data, function (company) {
                return {
                    id: company.id,
                    text: company.text
                };
            })
        };
    }
};
