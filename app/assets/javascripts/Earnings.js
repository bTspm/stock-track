var Earnings = {
    initChart: function (data) {
        Highcharts.chart('earnings-container', {

            title: {
                text: "",
            },

            subtitle: {
                text: "Earnings Per Share"
            },

            yAxis: {
                title: {
                    enabled: false
                }
            },
            lang: {
                noData: "No Data Available"
            },


            credits: {
                enabled: false
            },

            xAxis: {
                categories: data.categories
            },

            tooltip: {
                formatter: function () {
                    let s = [];
                    $.each(this.points, function (i, point) {
                        s.push(point.series.name + ' : ' + point.y);
                    });

                    return s.join('<br>');
                },
                crosshairs: true,
                shared: true,
            },

            series: [{
                states: {
                    hover: {
                        lineWidthPlus: 0
                    }
                },
                opacity: 2,
                lineWidth: 0,
                name: 'Actual',
                data: data.actual,
            }, {
                states: {
                    hover: {
                        lineWidthPlus: 0
                    }
                },
                lineWidth: 0,
                name: 'Estimated',
                data: data.estimated,
            }]
        });
    }
};

