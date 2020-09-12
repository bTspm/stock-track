const Notifications = {
    error: function (message, title, options) {
        toastr.options = Notifications._configOptions(options);
        toastr.error(message, title);
    },

    success: function (message, title, options) {
        toastr.options = Notifications._configOptions(options);
        toastr.success(message, title);
    },

    _configOptions: function (options) {
        let default_options = {
            "closeButton": true,
            "debug": false,
            "newestOnTop": true,
            "progressBar": true,
            "preventDuplicates": false,
            "showDuration": "300",
            "hideDuration": "1000",
            "timeOut": "5000",
            "extendedTimeOut": "1000"
        };

        if (options === undefined || options === null) {
            return default_options;
        }

        return $.extend({}, default_options, options);
    }
};
