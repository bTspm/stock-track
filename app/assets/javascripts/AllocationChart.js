const AllocationChart = {
    init: function (selector) {
        this.elements = {
            container: selector,
        };
        return this;
    },

    render: function (data) {
        debugger;
        Highcharts.chart(AllocationChart.elements.container, {
            chart: { type: "pie" },
            title: { text: data.title },
            tooltip: { pointFormat: "{point.name}: <b>{point.percentage:.1f}%</b>" },
            accessibility: { point: { valueSuffix: "%" } },
            credits: { enabled: false },
            legend: {
                enabled: true,
                labelFormatter: function () {
                    return (
                        '<span style="color:' +
                        this.color +
                        '">' +
                        this.name +
                        ": </span>(<b>" +
                        this.y +
                        ")<br/>"
                    );
                },
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: "pointer",
                    dataLabels: {
                        enabled: true,
                        format: "<b>{point.name}</b>: {point.percentage:.1f} %",
                    },
                    showInLegend: true,
                },
            },
            series: [
                {
                    data: data.data,
                    dataLabels: {
                        enabled: false,
                    },
                    innerSize: "60%",
                },
            ],
        });
    },
};
