<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="dashboard.aspx.cs" Inherits="adminsection_dashboard" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/no-data-to-display.js"></script>
    <script src="../js_chart/highchart-legend-extension.js"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="row" id="divfilter">
        <div class="col-md-6">
            <div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
        </div>
        <div class="col-md-6">
            <div id="Top10Suppliers" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
        </div>
    </div>

    <script>
        $(document).ready(function () {
            $.ajax({
                url: 'dashboard.aspx/LoadCategoryProductData',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    CategoryProductsData(JSON.parse(data.d));
                }
            });
            //Get Top 10 Suppliers
            $.ajax({
                url: 'dashboard.aspx/LoadTop10Suppliers',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    ShowTop10Suplliers(JSON.parse(data.d));
                }
            });
        });

        function CategoryProductsData(data) {
            //debugger;
            const chartObj = Highcharts.chart('container', {
                chart: {
                    type: 'column'
                },
                title: {
                    text: 'Products/Category'
                },
                //subtitle: {
                //    text: 'Click the columns to view versions. Source: <a href="http://statcounter.com" target="_blank">statcounter.com</a>'
                //},
                xAxis: {
                    title: {
                        text: 'Category'
                    },
                    categories: data.xaxisData
                },
                yAxis: {
                    title: {
                        text: 'Total Products'
                    }

                },
                legend: {
                    enabled: false
                },
                plotOptions: {
                    series: {
                        borderWidth: 0,
                        dataLabels: {
                            enabled: true,
                            format: '{point.y:.0f}'
                        }
                    }
                },

                tooltip: {
                    headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
                    formatter: function () {
                        return '<b>' + this.x + '</b> : ' + this.y + ' (Total Products)';
                    }
                    //pointFormat: '<span style="color:{point.name}">{point.name}</span>: <b>{point.y:.0f}</b> of total<br/>'
                },

                "series": [
                    {
                        "name": "Category",
                        "colorByPoint": true
                        //"data": JSON.parse(data.yaxisData)
                    }
                ]
            });


            // Simulate fetch request timeout, get data after some delay
            setTimeout(() => {
                chartObj.hideLoading()
                chartObj.series[0].setData(JSON.parse(data.yaxisData))
            }, 10)

            // Show loading screen
            chartObj.showLoading()
        }

        function ShowTop10Suplliers(data) {

            const chartObj = Highcharts.chart('Top10Suppliers', {
                chart: {
                    type: 'column'
                },
                title: {
                    text: 'Products/Suppliers'
                },
                xAxis: {
                    title: {
                        text: 'Top 10 Suppliers'
                    },
                    categories: data.xaxisData
                },
                yAxis: {
                    title: {
                        text: 'Total Products'
                    }
                },
                legend: {
                    enabled: false
                },
                plotOptions: {
                    series: {
                        borderWidth: 0,
                        dataLabels: {
                            enabled: true,
                            format: '{point.y:.0f}'
                        }
                    }
                },

                tooltip: {
                    headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
                    formatter: function () {
                        return '<b>' + this.x + '</b> : ' + this.y + ' (Total Products)';
                    }
                },
                "series": [
                    {
                        "name": "Suppliers",
                        "colorByPoint": true
                        //"data": JSON.parse(data.yaxisData)
                    }
                ]
            });

            // Simulate fetch request timeout, get data after some delay
            setTimeout(() => {
                chartObj.hideLoading()
                chartObj.series[0].setData(JSON.parse(data.yaxisData))
            }, 10)

            // Show loading screen
            chartObj.showLoading()
        }
    </script>
</asp:Content>

