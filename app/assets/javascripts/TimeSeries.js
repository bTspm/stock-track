var TimeSeries = {
    initChart: function (data) {
        Highcharts.stockChart('time-series-container', {
            navigator: {
                enabled: false
            },
            rangeSelector: {
                buttons: data.time_line_buttons,
                enabled: true,
                inputEnabled: true
            },

            credits: {
                enabled: false
            },

            plotOptions: {
                series: {
                    turboThreshold: 0
                }
            },

            title: {
                text: data.title,
            },
            subtitle: {
                text: data.subtitle,
            },

            xAxis: {
                gapGridLineWidth: 0
            },

            series: [{
                name: data.symbol,
                type: 'area',
                data: data.stock_data,
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
    },

    myCustomLabelFormatter: function () {
        var len = this.yData.length,
            sgn = this.yData[len - 1] >= this.yData[len - 2] ? "+" : "-";
        return this.name + ": " + (this.yData[0] / this.yData[len - 1]).toFixed(2) + "%";
    }

};