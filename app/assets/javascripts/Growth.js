var Growth = {
    initChart: function (data) {
        Highcharts.chart('growth-container', {
            chart: {
                type: 'line'
            },
            title: {
                text: ""
            },
            subtitle: {
                text: "Growth Percentage(%)"
            },
            legend: {
                enabled: false
            },

            lang: {
                noData: "No Data Available"
            },
            xAxis: {
                categories: data.xaxis_titles
            },
            yAxis: {
                labels: {
                    format: '{value} %'
                },
                title: {
                    enabled: false
                }
            },
            tooltip: {
                crosshairs: true,
                shared: true,
                valueSuffix: '%'
            },
            credits: {
                enabled: false
            },
            series: [{
                data: data.data,
                color: 'green',
                threshold: 0,
                negativeColor: "red",
                name: "Growth value",
            }]
        });
    }
};

