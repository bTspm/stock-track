const Search = {
    init: function () {
        this.elements = {
            selector: $('#search-field'),
            redirectPath: $("#search-field").attr("data-redirect-path")
        }

        this.constants = {
            MINIMUM_CHARACTERS: 1
        }

        return this;
    },

    render: function () {
        Search.search();
    },

    formatResult: function (suggestion) {
        return "<span class='suggestion-img'><img src='" + suggestion.logo_url + "'/></span>" +
            "<span class='suggestion-wrapper'>" +
            "<span class='suggestion-value'>" + suggestion.security_name_with_symbol + "</span>" +
            "<span class='sub-text'>" + suggestion.exchange_name_with_country_code + "</span></span>";
    },

    onSelect: function(suggestion){
        window.location.href = Search.elements.redirectPath + suggestion.id;
    },

    search: function () {
        Search.elements.selector.devbridgeAutocomplete({
            serviceUrl: "/search/basic",
            minChars: Search.constants.MINIMUM_CHARACTERS,
            onSelect: Search.onSelect,
            formatResult: Search.formatResult
        });
    },
};
