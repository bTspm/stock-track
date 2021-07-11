const CompanyPicker = (function () {
    const publicApi = {
        init: function (selector, options) {
            this.elements = {
                selector: selector
            };

            this.options = configOptions(options)

            return this;
        },

        render: function () {
            publicApi.elements.selector.select2({
                ajax: {
                    url: "/stocks/search",
                    data: function (params) {
                        return {
                            query: params.term // search term
                        };
                    },
                    dataType: 'json',
                    processResults: processResults,
                },
                theme: publicApi.options.theme,
                multiple: publicApi.options.multiple,
                templateResult: templateResult,
                templateSelection: templateSelection,
                placeholder: publicApi.options.placeholder,
                minimumInputLength: publicApi.options.minimumInputLength,
                maximumSelectionLength: publicApi.options.maximumSelectionLength
            })
        },
    };

    return publicApi;

    // private

    function configOptions(options) {
        const defaultOptions = {
            placeholder: 'Search Symbol',
            minimumInputLength: 1,
            maximumSelectionLength: 5,
            multiple: true,
            theme: "bootstrap",
        };

        if (options == null) {
            return defaultOptions;
        }
        return $.extend({}, defaultOptions, options);
    }

    function templateResult(company) {
        if (!company.id) {
            return company.security_name_with_symbol;
        }

        return $(
            "<span class='suggestion-img'><img src='" +
            company.logo_url +
            "'/></span>" +
            "<span class='suggestion-wrapper'>" +
            "<span class='suggestion-value'>" +
            company.security_name_with_symbol +
            "</span>" +
            "<span class='sub-text'>" +
            company.exchange_name +
            "</span></span>"
        );
    }

    function templateSelection(company) {
        return company.id
    }

    function processResults(data) {
        return {
            results: $.map(data.suggestions, function (company) {
                return {
                    exchange_name: company.exchange_name,
                    id: company.id,
                    logo_url: company.logo_url,
                    security_name_with_symbol: company.security_name_with_symbol,
                    value: company.value
                };
            })
        };
    }
})();
