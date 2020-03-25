var RecommendationTrends = {
    initChart: function (data) {
        Highcharts.chart('recommendation-trends-container', {
            chart: {
                type: 'column'
            },
            title: {
                text: ''
            },
            xAxis: {
                categories: data.categories
            },

            lang: {
                noData: "No Data Available"
            },

            yAxis: {
                labels: {
                    enabled: false
                },
                title: {
                    enabled: false
                }
            },

            credits: {
                enabled: false
            },

            tooltip: {
                headerFormat: '<b>{point.x}</b><br/>',
                pointFormat: '{series.name}: {point.y}<br/>No.of Analysts: {point.stackTotal}'
            },
            plotOptions: {
                column: {
                    stacking: 'normal',
                    dataLabels: {
                        enabled: true
                    }
                }
            },
            series: data.series
        });
    }
};
