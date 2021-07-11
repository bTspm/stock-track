var TimeSeries = {
    initChart: function (data) {
        Highcharts.stockChart('time-series-container', {
            navigator: {
                enabled: false
            },
            rangeSelector: {
                enabled: true,
                inputEnabled: false
            },

            credits: {
                enabled: false
            },

            plotOptions: {
                series: {
                    turboThreshold: 0
                }
            },

            tooltip: {
                split: false
            },

            series: [{
                name: "Price",
                type: 'area',
                data: data,
                gapSize: 5,
                tooltip: {
                    valueDecimals: 2
                },
                fillColor: {
                    linearGradient: {
                        x1: 0,
                        y1: 0,
                        x2: 0,
                        y2: 1
                    },
                    stops: [
                        [0, "#7cb5ec"],
                        [1, Highcharts.color(Highcharts.getOptions().colors[0]).setOpacity(0).get('rgba')]
                    ]
                },
                threshold: null
            }]
        });
    }
};
