const Compare = (function () {
    const publicApi = {
        init: function () {
            this.elements = {
                companySelectSelector: $("#company-select"),
                chartSelector: "compare-chart"
            };

            return this;
        },

        render: function (data) {
            CompanyPicker.init(publicApi.elements.companySelectSelector).render();
            compareChart(data);
        },
    };

    return publicApi;

    // private

    function compareChart(data){
        Highcharts.stockChart(publicApi.elements.chartSelector, {

            rangeSelector: {
                selected: 4,
                enabled: true,
                inputEnabled: false
            },

            legend: {
                enabled: true
            },

            navigator: {
                enabled: false
            },

            credits: {
                enabled: false
            },

            yAxis: {
                labels: {
                    formatter: function () {
                        return (this.value > 0 ? ' + ' : '') + this.value + '%';
                    }
                }
            },

            plotOptions: {
                series: {
                    compare: 'percent',
                    showInNavigator: true
                }
            },

            tooltip: {
                pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b> ({point.change}%)<br/>',
                valueDecimals: 2,
                split: true
            },

            series: data
        });
    }
})();
