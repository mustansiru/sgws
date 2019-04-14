/**
 * A Highcharts plugin for exporting data from a rendered chart as CSV, XLS or HTML table
 *
 * Author:   Torstein Honsi
 * Licence:  MIT
 * Version:  1.3.7
 */
/*global Highcharts, window, document, Blob */
(function (Highcharts) {

    'use strict';

    var each = Highcharts.each,
        pick = Highcharts.pick,
        downloadAttrSupported = document.createElement('a').download !== undefined;

    Highcharts.setOptions({
        lang: {
            downloadCSV: 'Download CSV',
            downloadXLS: 'Download XLS'
        }
    });


    /**
     * Get the data rows as a two dimensional array
     */
    Highcharts.Chart.prototype.getDataRows = function () {
        var options = (this.options.exporting || {}).csv || {},
            xAxis = this.xAxis[0],
            rows = {},
            rowArr = [],
            dataRows,
            names = [],
            i,
            x,

            // Options
            dateFormat = options.dateFormat || '%Y-%m-%d %H:%M:%S',
            columnHeaderFormatter = options.columnHeaderFormatter || function (series, key, keyLength) {
                return series.name.toString() + (keyLength > 1 ? ' (' + key + ')' : '');
            };

        // Loop the series and index values
        i = 0;
        each(this.series, function (series) {
            var keys = series.options.keys,
                pointArrayMap = keys || series.pointArrayMap || ['y'],
                valueCount = pointArrayMap.length,
                requireSorting = series.requireSorting,
                categoryMap = {},
                j;

            // Map the categories for value axes
            each(pointArrayMap, function (prop) {
                categoryMap[prop] = (series[prop + 'Axis'] && series[prop + 'Axis'].categories) || [];
            });

            if (series.options.includeInCSVExport !== false && series.visible !== false) { // #55
                j = 0;
                while (j < valueCount) {
                    names.push(columnHeaderFormatter(series, pointArrayMap[j], pointArrayMap.length));
                    j = j + 1;
                }

                each(series.points, function (point, pIdx) {
                    var key = requireSorting ? point.x : pIdx,
                        prop,
                        val;

                    j = 0;

                    if (!rows[key]) {
                        rows[key] = [];
                    }

                    if (window.location.href.indexOf("report.aspx?Path=RFID+EM+Display+Compliance+Reports%2fPerformance+By+Geography&type=1") > -1) {
                        rows[key].x = point.name;
                    }
                    else {
                        rows[key].x = point.x;
                    }

                    // Pies, funnels etc. use point name in X row
                    if (!series.xAxis) {
                        rows[key].name = point.name;
                    }

                    while (j < valueCount) {
                        prop = pointArrayMap[j]; // y, z etc
                        val = point[prop];


                        //////////////
                        if (window.location.href.indexOf("report.aspx?Path=RFID+EM+Display+Compliance+Reports%2fPerformance+By+Geography&type=1") > -1) {
                            if (GeographyWhichMapActive == 1)
                            { if (i == 1) { rows[key][(i + j) - 1] = point.Y + '%'; } else { rows[key][i + j] = '-'; } }
                            else {
                                if (point.value == 0)
                                    rows[key][i + j] = '-';
                                else
                                    rows[key][i + j] = point.value + '%';
                            }
                        }
                        else {
                            rows[key][i + j] = pick(categoryMap[prop][val], val); // Pick a Y axis category if present
                        }
                        j = j + 1;
                    }

                });
                i = i + j;
            }
        });

        // Make a sortable array
        for (x in rows) {
            if (rows.hasOwnProperty(x)) {
                rowArr.push(rows[x]);
            }
        }
        // Sort it by X values
        rowArr.sort(function (a, b) {
            return a.x - b.x;
        });

        // Add header row
        dataRows = [[xAxis.isDatetimeAxis ? 'DateTime' : 'Category'].concat(names)];

        // Transform the rows to CSV
        each(rowArr, function (row) {

            var category = row.name;
            if (!category) {
                if (xAxis.isDatetimeAxis) {
                    category = Highcharts.dateFormat(dateFormat, row.x);
                } else if (xAxis.categories) {
                    category = pick(xAxis.names[row.x], xAxis.categories[row.x], row.x)
                } else {
                    category = row.x;
                }
            }

            // Add the X/date/category
            row.unshift(category);
            dataRows.push(row);
        });

        return dataRows;
    };

    /**
     * Get a CSV string
     */
    Highcharts.Chart.prototype.getCSV = function (useLocalDecimalPoint) {
        var csv = '',
            rows = this.getDataRows(),
            options = (this.options.exporting || {}).csv || {},
            itemDelimiter = options.itemDelimiter || ',', // use ';' for direct import to Excel
            lineDelimiter = options.lineDelimiter || '\n'; // '\n' isn't working with the js csv data extraction

        // Add title to csv
        var rowtitle1 = [];

        if (window.location.href.indexOf("report.aspx?Path=RFID+EM+Display+Compliance+Reports%2fPerformance+By+Geography&type=1") > -1) {
            rowtitle1.push('Performance By Geography');
        }
        else {
            if (this.title != undefined) {
                rowtitle1.push(this.title.textStr.replace("’", "'"));
            }
            else { rowtitle1.push('Report'); }
        }

        rowtitle1.push('');
        rowtitle1.push(lineDelimiter);
        csv += rowtitle1.join(itemDelimiter);
        rowtitle1 = [];
        rowtitle1.push(($.trim($("#divReportGenarationTitle").text())).replace(/\s\s+/g, ' ').replace("’", "'"));
        rowtitle1.push('');
        rowtitle1.push(lineDelimiter);
        csv += rowtitle1.join(itemDelimiter);
        rowtitle1 = [];
        rowtitle1.push('');
        rowtitle1.push('');
        rowtitle1.push(lineDelimiter);
        csv += rowtitle1.join(itemDelimiter);


        // Transform the rows to CSV
        each(rows, function (row, i) {
            var val = '',
                j = row.length,
                n = useLocalDecimalPoint ? (1.1).toLocaleString()[1] : '.';
            while (j--) {
                val = row[j];
                if (typeof val === "string") {
                    val = '"' + val.toString().replace("’", "'") + '"';
                }
                if (typeof val === 'number') {
                    if (n === ',') {
                        val = val.toString().replace(".", ",");
                    }
                }
                row[j] = val;
            }
            // Add the values
            csv += row.join(itemDelimiter);

            // Add the line delimiter
            if (i < rows.length - 1) {
                csv += lineDelimiter;
            }
        });
        return csv;
    };

    /**
     * Build a HTML table with the data
     */
    Highcharts.Chart.prototype.getTable = function (useLocalDecimalPoint) {
        var html = '<table>',
            rows = this.getDataRows();

        // Transform the rows to HTML
        each(rows, function (row, i) {
            var tag = i ? 'td' : 'th',
                val,
                j,
                n = useLocalDecimalPoint ? (1.1).toLocaleString()[1] : '.';

            html += '<tr>';
            for (j = 0; j < row.length; j = j + 1) {
                val = row[j];
                // Add the cell
                if (typeof val === 'number') {
                    if (n === ',') {
                        html += '<' + tag + (typeof val === 'number' ? ' class="number"' : '') + '>' + val.toString().replace(".", ",") + '</' + tag + '>';
                    } else {
                        html += '<' + tag + (typeof val === 'number' ? ' class="number"' : '') + '>' + val.toString() + '</' + tag + '>';
                    }
                } else {
                    html += '<' + tag + '>' + val.toString() + '</' + tag + '>';
                }
            }

            html += '</tr>';
        });
        html += '</table>';
        return html;
    };

    function getContent(chart, href, extension, content, MIME) {
        var a,
            blobObject,
            name,
            options = (chart.options.exporting || {}).csv || {},
            url = options.url || 'http://www.highcharts.com/studies/csv-export/download.php';

        if (window.location.href.indexOf("report.aspx?Path=RFID+EM+Display+Compliance+Reports%2fPerformance+By+Geography&type=1") > -1) {
            name = 'Performance By Geography';
        }
        else {
            if (chart.options.exporting.filename) {
                name = chart.options.exporting.filename;
            } else if (chart.title) {
                name = chart.title.textStr.replace(/ /g, '-').toLowerCase();
            } else {
                name = 'Report';
            }
        }

        // Download attribute supported
        if (downloadAttrSupported) {
            a = document.createElement('a');
            a.href = href;
            a.target = '_blank';
            a.download = name.replace("&gt;", "greater than ") + '.' + extension;
            document.body.appendChild(a);
            a.click();
            a.remove();

        } else if (window.Blob && window.navigator.msSaveOrOpenBlob) {
            // Falls to msSaveOrOpenBlob if download attribute is not supported
            blobObject = new Blob([content]);
            window.navigator.msSaveOrOpenBlob(blobObject, name + '.' + extension);

        } else {
            // Fall back to server side handling
            Highcharts.post(url, {
                data: content,
                type: MIME,
                extension: extension
            });
        }
    }

    /**
     * Call this on click of 'Download CSV' button
     */
    Highcharts.Chart.prototype.downloadCSV = function () {
        var csv = this.getCSV(true);
        getContent(
            this,
            'data:text/csv,' + csv.replace(/\n/g, '%0A'),
            'csv',
            csv,
            'text/csv'
        );
    };

    /**
     * Call this on click of 'Download XLS' button
     */
    Highcharts.Chart.prototype.downloadXLS = function () {
        var uri = 'data:application/vnd.ms-excel;base64,',
            template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">' +
                '<head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet>' +
                '<x:Name>Ark1</x:Name>' +
                '<x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]-->' +
                '<style>td{border:none;font-family: Calibri, sans-serif;} .number{mso-number-format:"0.00";}</style>' +
                '<meta name=ProgId content=Excel.Sheet>' +
                '</head><body>' +
                this.getTable(true) +
                '</body></html>',
            base64 = function (s) {
                return window.btoa(unescape(encodeURIComponent(s))); // #50
            };
        getContent(
            this,
            uri + base64(template),
            'xls',
            template,
            'application/vnd.ms-excel'
        );
    };


    // Add "Download CSV" to the exporting menu. Use download attribute if supported, else
    // run a simple PHP script that returns a file. The source code for the PHP script can be viewed at
    // https://raw.github.com/highslide-software/highcharts.com/master/studies/csv-export/csv.php
    if (Highcharts.getOptions().exporting) {
        Highcharts.getOptions().exporting.buttons.contextButton.menuItems.push({
            textKey: 'downloadCSV',
            onclick: function () { this.downloadCSV(); }
        }, {
            textKey: 'downloadXLS',
            //onclick: function () { this.downloadXLS(); }
            onclick: function () {

                $('#newTempControl').html(this.getTable(true));
                if (window.location.href.indexOf("report.aspx?Path=RFID+EM+Display+Compliance+Reports%2fPerformance+By+Geography&type=1") > -1) {
                    $('#newTempTitleControl').html('Performance By Geography');
                }
                else {
                    if (this.title != undefined) {
                        $('#newTempTitleControl').html(this.title.textStr);
                    }
                    else {
                        $('#newTempTitleControl').html('Report');
                    }
                }

                ExportToExcel('newTempTitleControl', 'divReportGenarationTitle', '', 'newTempControl', $('#newTempTitleControl').html());
                $('#newTempControl').html('');
                $('#newTempTitleControl').html('');
            }
        });
    }

}(Highcharts));
