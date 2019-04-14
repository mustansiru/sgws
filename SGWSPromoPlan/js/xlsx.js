

function generateArray(maintitle, subtitle, subsubtitle, table) {

    var out = [];
    var rows = table.querySelectorAll('tr');
    var ranges = [];

    var firstRow = [];
    var FirstcellValue = '';

    firstRow.push(maintitle);
    out.push(firstRow);
    firstRow = [];
    firstRow.push(subtitle);
    out.push(firstRow);
    firstRow = [];
    firstRow.push('');
    out.push(firstRow);
    if (subsubtitle != '') {
        firstRow = [];
        firstRow.push(subsubtitle);
        out.push(firstRow);
        firstRow = [];
        firstRow.push('');
        out.push(firstRow);
    }
    firstRow = [];

    var headers = ['Store', 'Is HotSeller', 'Category', 'Vendor', 'Vendor ID', 'Style ID', 'Color ID', 'Description', 'Product Image', 'Action Taken', 'Add To Hotseller'];

    var Last_4_week_CC_headers = ['Store', 'Category', 'Target Met', 'Target Missed'];

    var columns_th = table.querySelectorAll('th');
    for (var Cth = 0; Cth < columns_th.length; ++Cth) {
        var cellth = columns_th[Cth];
        if (maintitle == 'Display Exceptions Report')
        { FirstcellValue = headers[Cth] }
        else if (maintitle.toString().search('Last 4 Weeks') == 0) {
            FirstcellValue = Last_4_week_CC_headers[Cth]
        }
        else if (maintitle == "Cycle Count User Ranking") {
            FirstcellValue = $(cellth).find('select option:first-child').html()
        }
        else {
            FirstcellValue = cellth.innerHTML.replace("&gt;", ">").replace("&lt;", "<");
        }
        firstRow.push(FirstcellValue !== "" ? FirstcellValue : null);
    }

    out.push(firstRow);

    for (var R = 1; R < rows.length; ++R) {
        var outRow = [];
        var row = rows[R];
        var columns = row.querySelectorAll('td');
        for (var C = 0; C < columns.length; ++C) {
            var cell = columns[C];

            var colspan = cell.getAttribute('colspan');
            var rowspan = cell.getAttribute('rowspan');
            var cellValue = cell.innerHTML;

            if (cellValue.toString().indexOf('&gt;') >= 0) {
                cellValue = cellValue.replace("&gt;", ">");
            }
            if (cellValue.toString().indexOf('&lt;') >= 0) {
                cellValue = cellValue.replace("&lt;", "<");
            }

            if (cellValue.toString().indexOf('<img src="images/incomplete.png"') >= 0) {
                cellValue = "No";
            }
            else if (cellValue.toString().indexOf('<span style=\"display:none"\>.</span><img src="images/complete.png"') >= 0) {
                cellValue = "Yes";
            }
            else if (cellValue.toString().indexOf('<span style="display:none;">hotseller</span>') >= 0) {
                cellValue = "Yes";
            }
            else if (cellValue.toString().indexOf('Regular') >= 0) {
                cellValue = "No";
            }
            else {
                if ((cellValue.toString().search('<div') == 0) || (cellValue.toString().search('<a') == 0))
                { cellValue = $(cellValue).html(); }
                else if ((cellValue.toString().search('<img') == 0)) {
                    if (maintitle == 'Display Exceptions Report')
                        cellValue = $(cellValue).attr('alturl');//$(cellValue).html();
                    else
                        cellValue = $(cellValue).attr('src');//$(cellValue).html();
                }
            }

            if (cellValue !== "" && cellValue == +cellValue) cellValue = +cellValue;

            //Skip ranges
            ranges.forEach(function (range) {
                if (R >= range.s.r && R <= range.e.r && outRow.length >= range.s.c && outRow.length <= range.e.c) {
                    for (var i = 0; i <= range.e.c - range.s.c; ++i) outRow.push(null);
                }
            });

            //Handle Row Span
            if (rowspan || colspan) {
                rowspan = rowspan || 1;
                colspan = colspan || 1;
                ranges.push({ s: { r: R, c: outRow.length }, e: { r: R + rowspan - 1, c: outRow.length + colspan - 1 } });
            };

            //Handle Value
            outRow.push(cellValue !== "" ? cellValue : null);

            //Handle Colspan
            if (colspan) for (var k = 0; k < colspan - 1; ++k) outRow.push(null);
        }
        out.push(outRow);
    }
    return [out, ranges];
};

function datenum(v, date1904) {
    if (date1904) v += 1462;
    var epoch = Date.parse(v);
    return (epoch - new Date(Date.UTC(1899, 11, 30))) / (24 * 60 * 60 * 1000);
}

function sheet_from_array_of_arrays(data, opts) {
    var ws = {};
    var range = { s: { c: 10000000, r: 10000000 }, e: { c: 0, r: 0 } };
    for (var R = 0; R != data.length; ++R) {
        for (var C = 0; C != data[R].length; ++C) {
            if (range.s.r > R) range.s.r = R;
            if (range.s.c > C) range.s.c = C;
            if (range.e.r < R) range.e.r = R;
            if (range.e.c < C) range.e.c = C;
            var cell = { v: data[R][C] };
            if (cell.v == null) continue;
            var cell_ref = XLSX.utils.encode_cell({ c: C, r: R });

            if (typeof cell.v === 'number') cell.t = 'n';
            else if (typeof cell.v === 'boolean') cell.t = 'b';
            else if (cell.v instanceof Date) {
                cell.t = 'n'; cell.z = XLSX.SSF._table[14];
                cell.v = datenum(cell.v);
            }
            else cell.t = 's';

            ws[cell_ref] = cell;
        }
    }
    if (range.s.c < 10000000) ws['!ref'] = XLSX.utils.encode_range(range);
    return ws;
}

function Workbook() {
    if (!(this instanceof Workbook)) return new Workbook();
    this.SheetNames = [];
    this.Sheets = {};
}

function s2ab(s) {
    var buf = new ArrayBuffer(s.length);
    var view = new Uint8Array(buf);
    for (var i = 0; i != s.length; ++i) view[i] = s.charCodeAt(i) & 0xFF;
    return buf;
}

function export_table_to_excel(maintitle, subtitle, subsubtitle, id, filename) {
    var theTable = document.getElementById(id).cloneNode(true);
    if (id.toString() == "tblDetailedComplianceStatistics") {
        $(".hide_date_or_store", theTable).remove();
        $(".a_padding", theTable).remove();
    }
    else if (id.toString() == "tblCycleCount_Last4WeeksPerformance") {
        $("img", theTable).remove();
        $(".showperformance", theTable).attr("style", "display:block;");
    }

    var oo = generateArray(maintitle, subtitle, subsubtitle, theTable);
    var ranges = oo[1];
    /* original data */
    var data = oo[0];
    var ws_name = "Report";

    var wb = new Workbook(), ws = sheet_from_array_of_arrays(data);

    /* add ranges to worksheet */
    ws['!merges'] = ranges;

    /* add worksheet to workbook */
    wb.SheetNames.push(ws_name);
    wb.Sheets[ws_name] = ws;

    var wbout = XLSX.write(wb, { bookType: 'xlsx', bookSST: false, type: 'binary' });
    saveAs(new Blob([s2ab(wbout)], { type: "application/octet-stream" }), filename.replace("&gt;", "greater than ").replace("&lt;", "less than ") + ".xlsx")
}

function generateArray_2_tables(maintitle, subtitle, tabletitle_1, table_1, tabletitle_2, table_2) {

    var out = [];
    var rows = table_1.querySelectorAll('tr');
    var ranges = [];

    var firstRow = [];
    var FirstcellValue = '';

    firstRow.push(maintitle);
    out.push(firstRow);
    firstRow = [];
    firstRow.push(subtitle);
    out.push(firstRow);
    firstRow = [];
    firstRow.push('');
    out.push(firstRow);
    firstRow = [];
    firstRow.push(tabletitle_1);
    out.push(firstRow);
    firstRow = [];
    firstRow.push('');
    out.push(firstRow);
    firstRow = [];
    var columns_th = table_1.querySelectorAll('th');
    for (var Cth = 0; Cth < columns_th.length; ++Cth) {
        var cellth = columns_th[Cth];
        FirstcellValue = cellth.innerHTML;
        firstRow.push(FirstcellValue !== "" ? FirstcellValue : null);
    }

    out.push(firstRow);

    for (var R = 1; R < rows.length; ++R) {
        var outRow = [];
        var row = rows[R];
        var columns = row.querySelectorAll('td');
        for (var C = 0; C < columns.length; ++C) {
            var cell = columns[C];

            var colspan = cell.getAttribute('colspan');
            var rowspan = cell.getAttribute('rowspan');
            var cellValue = cell.innerHTML;

            if ((cellValue.toString().search('<div') == 0) || (cellValue.toString().search('<a') == 0))
                cellValue = $(cellValue).html();

            if (cellValue !== "" && cellValue == +cellValue) cellValue = +cellValue;

            //Skip ranges
            ranges.forEach(function (range) {
                if (R >= range.s.r && R <= range.e.r && outRow.length >= range.s.c && outRow.length <= range.e.c) {
                    for (var i = 0; i <= range.e.c - range.s.c; ++i) outRow.push(null);
                }
            });

            //Handle Row Span
            if (rowspan || colspan) {
                rowspan = rowspan || 1;
                colspan = colspan || 1;
                ranges.push({ s: { r: R, c: outRow.length }, e: { r: R + rowspan - 1, c: outRow.length + colspan - 1 } });
            };

            //Handle Value
            outRow.push(cellValue !== "" ? cellValue : null);

            //Handle Colspan
            if (colspan) for (var k = 0; k < colspan - 1; ++k) outRow.push(null);
        }
        out.push(outRow);
    }

    // 2nd table rows

    var rows_2 = table_2.querySelectorAll('tr');
    var ranges_2 = [];

    var firstRow_2 = [];
    var FirstcellValue_2 = '';

    firstRow_2 = [];
    firstRow_2.push('');
    out.push(firstRow_2);
    firstRow_2 = [];
    firstRow_2.push(tabletitle_2);
    out.push(firstRow_2);
    firstRow_2 = [];
    firstRow_2.push('');
    out.push(firstRow_2);
    firstRow_2 = [];
    var columns_th_2 = table_2.querySelectorAll('th');
    for (var Cth = 0; Cth < columns_th_2.length; ++Cth) {
        var cellth = columns_th_2[Cth];
        FirstcellValue_2 = cellth.innerHTML;
        firstRow_2.push(FirstcellValue_2 !== "" ? FirstcellValue_2 : null);
    }

    out.push(firstRow_2);

    for (var R = 1; R < rows_2.length; ++R) {
        var outRow = [];
        var row = rows_2[R];
        var columns = row.querySelectorAll('td');
        for (var C = 0; C < columns.length; ++C) {
            var cell = columns[C];

            var colspan = cell.getAttribute('colspan');
            var rowspan = cell.getAttribute('rowspan');
            var cellValue = cell.innerHTML;

            if ((cellValue.toString().search('<div') == 0) || (cellValue.toString().search('<a') == 0))
                cellValue = $(cellValue).html();

            if (cellValue !== "" && cellValue == +cellValue) cellValue = +cellValue;

            //Skip ranges
            ranges.forEach(function (range) {
                if (R >= range.s.r && R <= range.e.r && outRow.length >= range.s.c && outRow.length <= range.e.c) {
                    for (var i = 0; i <= range.e.c - range.s.c; ++i) outRow.push(null);
                }
            });

            //Handle Row Span
            if (rowspan || colspan) {
                rowspan = rowspan || 1;
                colspan = colspan || 1;
                ranges.push({ s: { r: R, c: outRow.length }, e: { r: R + rowspan - 1, c: outRow.length + colspan - 1 } });
            };

            //Handle Value
            outRow.push(cellValue !== "" ? cellValue : null);

            //Handle Colspan
            if (colspan) for (var k = 0; k < colspan - 1; ++k) outRow.push(null);
        }
        out.push(outRow);
    }

    return [out, ranges];
};

function export_table_to_excel_2_tables(maintitle, subtitle, title_table_1, table_id_1, title_table_2, table_id_2, filename) {
    var theTable1 = document.getElementById(table_id_1);
    var theTable2 = document.getElementById(table_id_2);
    var oo = generateArray_2_tables(maintitle, subtitle, title_table_1, theTable1, title_table_2, theTable2);

    //var theTable2 = document.getElementById(table_id_2);
    //oo += generateArray(maintitle, subtitle, theTable2);

    var ranges = oo[1];
    /* original data */
    var data = oo[0];
    var ws_name = "Report";

    var wb = new Workbook(), ws = sheet_from_array_of_arrays(data);

    /* add ranges to worksheet */
    ws['!merges'] = ranges;

    /* add worksheet to workbook */
    wb.SheetNames.push(ws_name);
    wb.Sheets[ws_name] = ws;

    var wbout = XLSX.write(wb, { bookType: 'xlsx', bookSST: false, type: 'binary' });
    saveAs(new Blob([s2ab(wbout)], { type: "application/octet-stream" }), filename.replace("&gt;", "greater than ").replace("&lt;", "less than ") + ".xlsx")
}

function generateArray_N_tables(maintitle, subtitle, subsubtitle, _tabletitles, _tableids) {

    var tableids = _tableids.split(",");
    var tabletitles = _tabletitles.split(",");

    var out = [];
    var rows;
    var ranges = [];

    var firstRow = [];
    var FirstcellValue = '';

    firstRow.push(maintitle);
    out.push(firstRow);
    if (subtitle != '') {
        firstRow = [];
        firstRow.push(subtitle);
        out.push(firstRow);
    }
    if (subsubtitle != '') {
        firstRow = [];
        firstRow.push('');
        out.push(firstRow);
        firstRow = [];
        firstRow.push(subsubtitle);
        out.push(firstRow);
    }

    for (var i = 0; i < tabletitles.length; i++) {
        var tablecontrol = document.getElementById(tableids[i]);
        rows = tablecontrol.querySelectorAll('tr');

        if (tabletitles[i] != 'Total') {
            firstRow = [];
            firstRow.push('');
            out.push(firstRow);
            firstRow = [];
            firstRow.push(tabletitles[i].replace(/’/g, "'"));
            out.push(firstRow);
            firstRow = [];
            firstRow.push('');
            out.push(firstRow);
        }
        firstRow = [];
        var columns_th = tablecontrol.querySelectorAll('th');
        for (var Cth = 0; Cth < columns_th.length; ++Cth) {
            var cellth = columns_th[Cth];
            FirstcellValue = cellth.innerHTML;
            firstRow.push(FirstcellValue !== "" ? FirstcellValue : null);
        }

        out.push(firstRow);

        for (var R = 1; R < rows.length; ++R) {
            var outRow = [];
            var row = rows[R];
            var columns = row.querySelectorAll('td');

            for (var C = 0; C < columns.length; ++C) {
                var cell = columns[C];
                var colspan = cell.getAttribute('colspan');
                var rowspan = cell.getAttribute('rowspan');
                var cellValue = cell.innerHTML;

                if ((cellValue.toString().search('<div') == 0) || (cellValue.toString().search('<a') == 0) || (cellValue.toString().search('<b') == 0)) {
                    cellValue = $(cellValue).html().replace(/&nbsp;/g, '');
                }

                if (cellValue !== "" && cellValue == +cellValue) cellValue = +cellValue;

                //Skip ranges
                ranges.forEach(function (range) {
                    if (R >= range.s.r && R <= range.e.r && outRow.length >= range.s.c && outRow.length <= range.e.c) {
                        for (var i = 0; i <= range.e.c - range.s.c; ++i) { outRow.push(null); }
                    }
                });

                //Handle Row Span
                if (rowspan || colspan) {
                    if (rowspan>1 || colspan>1) {
                        rowspan = rowspan || 1;
                        colspan = colspan || 1;
                        ranges.push({ s: { r: R, c: outRow.length }, e: { r: R + rowspan - 1, c: outRow.length + colspan - 1 } });
                    }
                };

                //Handle Value
                outRow.push(cellValue !== "" ? cellValue : null);
                //Handle Colspan
                if (colspan) for (var k = 0; k < colspan - 1; ++k) { outRow.push(null); };
            }

            out.push(outRow);
        }
    }
    return [out, ranges];
};

function export_table_to_excel_N_tables(maintitle, subtitle, subsubtitle, titles, tableids, filename) {
    var oo = generateArray_N_tables(maintitle, subtitle, subsubtitle, titles, tableids);
    var ranges = oo[1];
    /* original data */
    var data = oo[0];

    var ws_name = "Report";

    var wb = new Workbook(), ws = sheet_from_array_of_arrays(data);

    /* add ranges to worksheet */
    ws['!merges'] = ranges;

    /* add worksheet to workbook */
    wb.SheetNames.push(ws_name);
    wb.Sheets[ws_name] = ws;

    var wbout = XLSX.write(wb, { bookType: 'xlsx', bookSST: false, type: 'binary' });
    saveAs(new Blob([s2ab(wbout)], { type: "application/octet-stream" }), filename.replace("&gt;", "greater than ").replace("&lt;", "less than ") + ".xlsx")
}

function generateArray_4_tables(maintitle, subtitle, tabletitle_1, table_1, tabletitle_2, table_2, tabletitle_3, table_3, tabletitle_4, table_4) {

    var out = [];
    var rows = table_1.querySelectorAll('tr');
    var ranges = [];

    var firstRow = [];
    var FirstcellValue = '';

    firstRow.push(maintitle);
    out.push(firstRow);
    firstRow = [];
    firstRow.push(subtitle);
    out.push(firstRow);
    firstRow = [];
    firstRow.push('');
    out.push(firstRow);
    firstRow = [];
    firstRow.push(tabletitle_1);
    out.push(firstRow);
    firstRow = [];
    firstRow.push('');
    out.push(firstRow);
    firstRow = [];
    var columns_th = table_1.querySelectorAll('th');
    for (var Cth = 0; Cth < columns_th.length; ++Cth) {
        var cellth = columns_th[Cth];
        FirstcellValue = cellth.innerHTML;
        firstRow.push(FirstcellValue !== "" ? FirstcellValue : null);
    }

    out.push(firstRow);

    for (var R = 1; R < rows.length; ++R) {
        var outRow = [];
        var row = rows[R];
        var columns = row.querySelectorAll('td');
        for (var C = 0; C < columns.length; ++C) {
            var cell = columns[C];

            var colspan = cell.getAttribute('colspan');
            var rowspan = cell.getAttribute('rowspan');
            var cellValue = cell.innerHTML;

            if ((cellValue.toString().search('<div') == 0) || (cellValue.toString().search('<a') == 0))
                cellValue = $(cellValue).html();

            if (cellValue !== "" && cellValue == +cellValue) cellValue = +cellValue;

            //Skip ranges
            ranges.forEach(function (range) {
                if (R >= range.s.r && R <= range.e.r && outRow.length >= range.s.c && outRow.length <= range.e.c) {
                    for (var i = 0; i <= range.e.c - range.s.c; ++i) outRow.push(null);
                }
            });

            //Handle Row Span
            if (rowspan || colspan) {
                rowspan = rowspan || 1;
                colspan = colspan || 1;
                ranges.push({ s: { r: R, c: outRow.length }, e: { r: R + rowspan - 1, c: outRow.length + colspan - 1 } });
            };

            //Handle Value
            outRow.push(cellValue !== "" ? cellValue : null);

            //Handle Colspan
            if (colspan) for (var k = 0; k < colspan - 1; ++k) outRow.push(null);
        }
        out.push(outRow);
    }

    // 2nd table rows

    var rows_2 = table_2.querySelectorAll('tr');
    var ranges_2 = [];

    var firstRow_2 = [];
    var FirstcellValue_2 = '';

    firstRow_2 = [];
    firstRow_2.push('');
    out.push(firstRow_2);
    firstRow_2 = [];
    firstRow_2.push(tabletitle_2);
    out.push(firstRow_2);
    firstRow_2 = [];
    firstRow_2.push('');
    out.push(firstRow_2);
    firstRow_2 = [];
    var columns_th_2 = table_2.querySelectorAll('th');
    for (var Cth = 0; Cth < columns_th_2.length; ++Cth) {
        var cellth = columns_th_2[Cth];
        FirstcellValue_2 = cellth.innerHTML;
        firstRow_2.push(FirstcellValue_2 !== "" ? FirstcellValue_2 : null);
    }

    out.push(firstRow_2);

    for (var R = 1; R < rows_2.length; ++R) {
        var outRow = [];
        var row = rows_2[R];
        var columns = row.querySelectorAll('td');
        for (var C = 0; C < columns.length; ++C) {
            var cell = columns[C];

            var colspan = cell.getAttribute('colspan');
            var rowspan = cell.getAttribute('rowspan');
            var cellValue = cell.innerHTML;

            if ((cellValue.toString().search('<div') == 0) || (cellValue.toString().search('<a') == 0))
                cellValue = $(cellValue).html();

            if (cellValue !== "" && cellValue == +cellValue) cellValue = +cellValue;

            //Skip ranges
            ranges.forEach(function (range) {
                if (R >= range.s.r && R <= range.e.r && outRow.length >= range.s.c && outRow.length <= range.e.c) {
                    for (var i = 0; i <= range.e.c - range.s.c; ++i) outRow.push(null);
                }
            });

            //Handle Row Span
            if (rowspan || colspan) {
                rowspan = rowspan || 1;
                colspan = colspan || 1;
                ranges.push({ s: { r: R, c: outRow.length }, e: { r: R + rowspan - 1, c: outRow.length + colspan - 1 } });
            };

            //Handle Value
            outRow.push(cellValue !== "" ? cellValue : null);

            //Handle Colspan
            if (colspan) for (var k = 0; k < colspan - 1; ++k) outRow.push(null);
        }
        out.push(outRow);
    }

    // 3rd table rows

    var rows_3 = table_3.querySelectorAll('tr');
    var ranges_3 = [];

    var firstRow_3 = [];
    var FirstcellValue_3 = '';

    firstRow_3 = [];
    firstRow_3.push('');
    out.push(firstRow_3);
    firstRow_3 = [];
    firstRow_3.push(tabletitle_3);
    out.push(firstRow_3);
    firstRow_3 = [];
    firstRow_3.push('');
    out.push(firstRow_3);
    firstRow_3 = [];
    var columns_th_3 = table_3.querySelectorAll('th');
    for (var Cth = 0; Cth < columns_th_3.length; ++Cth) {
        var cellth = columns_th_3[Cth];
        FirstcellValue_3 = cellth.innerHTML;
        firstRow_3.push(FirstcellValue_3 !== "" ? FirstcellValue_3 : null);
    }

    out.push(firstRow_3);

    for (var R = 1; R < rows_3.length; ++R) {
        var outRow = [];
        var row = rows_3[R];
        var columns = row.querySelectorAll('td');
        for (var C = 0; C < columns.length; ++C) {
            var cell = columns[C];

            var colspan = cell.getAttribute('colspan');
            var rowspan = cell.getAttribute('rowspan');
            var cellValue = cell.innerHTML;

            if ((cellValue.toString().search('<div') == 0) || (cellValue.toString().search('<a') == 0))
                cellValue = $(cellValue).html();

            if (cellValue !== "" && cellValue == +cellValue) cellValue = +cellValue;

            //Skip ranges
            ranges.forEach(function (range) {
                if (R >= range.s.r && R <= range.e.r && outRow.length >= range.s.c && outRow.length <= range.e.c) {
                    for (var i = 0; i <= range.e.c - range.s.c; ++i) outRow.push(null);
                }
            });

            //Handle Row Span
            if (rowspan || colspan) {
                rowspan = rowspan || 1;
                colspan = colspan || 1;
                ranges.push({ s: { r: R, c: outRow.length }, e: { r: R + rowspan - 1, c: outRow.length + colspan - 1 } });
            };

            //Handle Value
            outRow.push(cellValue !== "" ? cellValue : null);

            //Handle Colspan
            if (colspan) for (var k = 0; k < colspan - 1; ++k) outRow.push(null);
        }
        out.push(outRow);
    }

    // 4th table rows

    var rows_4 = table_4.querySelectorAll('tr');
    var ranges_4 = [];

    var firstRow_4 = [];
    var FirstcellValue_4 = '';

    firstRow_4 = [];
    firstRow_4.push('');
    out.push(firstRow_4);
    firstRow_4 = [];
    firstRow_4.push(tabletitle_4);
    out.push(firstRow_4);
    firstRow_4 = [];
    firstRow_4.push('');
    out.push(firstRow_4);
    firstRow_4 = [];
    var columns_th_4 = table_4.querySelectorAll('th');
    for (var Cth = 0; Cth < columns_th_4.length; ++Cth) {
        var cellth = columns_th_4[Cth];
        FirstcellValue_4 = cellth.innerHTML;
        firstRow_4.push(FirstcellValue_4 !== "" ? FirstcellValue_4 : null);
    }

    out.push(firstRow_4);

    for (var R = 1; R < rows_4.length; ++R) {
        var outRow = [];
        var row = rows_4[R];
        var columns = row.querySelectorAll('td');
        for (var C = 0; C < columns.length; ++C) {
            var cell = columns[C];

            var colspan = cell.getAttribute('colspan');
            var rowspan = cell.getAttribute('rowspan');
            var cellValue = cell.innerHTML;

            if ((cellValue.toString().search('<div') == 0) || (cellValue.toString().search('<a') == 0) || (cellValue.toString().search('<img') == 0))
                cellValue = $(cellValue).html();

            if (cellValue !== "" && cellValue == +cellValue) cellValue = +cellValue;

            //Skip ranges
            ranges.forEach(function (range) {
                if (R >= range.s.r && R <= range.e.r && outRow.length >= range.s.c && outRow.length <= range.e.c) {
                    for (var i = 0; i <= range.e.c - range.s.c; ++i) outRow.push(null);
                }
            });

            //Handle Row Span
            if (rowspan || colspan) {
                rowspan = rowspan || 1;
                colspan = colspan || 1;
                ranges.push({ s: { r: R, c: outRow.length }, e: { r: R + rowspan - 1, c: outRow.length + colspan - 1 } });
            };

            //Handle Value
            outRow.push(cellValue !== "" ? cellValue : null);

            //Handle Colspan
            if (colspan) for (var k = 0; k < colspan - 1; ++k) outRow.push(null);
        }
        out.push(outRow);
    }

    return [out, ranges];
};

function export_table_to_excel_4_tables(maintitle, subtitle, title_table_1, table_id_1, title_table_2, table_id_2, title_table_3, table_id_3, title_table_4, table_id_4, filename) {
    var theTable1 = document.getElementById(table_id_1);
    var theTable2 = document.getElementById(table_id_2);
    var theTable3 = document.getElementById(table_id_3);
    var theTable4 = document.getElementById(table_id_4);
    var oo = generateArray_4_tables(maintitle, subtitle, title_table_1, theTable1, title_table_2, theTable2, title_table_3, theTable3, title_table_4, theTable4);

    //var theTable2 = document.getElementById(table_id_2);
    //oo += generateArray(maintitle, subtitle, theTable2);

    var ranges = oo[1];
    /* original data */
    var data = oo[0];
    var ws_name = "Report";

    var wb = new Workbook(), ws = sheet_from_array_of_arrays(data);

    /* add ranges to worksheet */
    ws['!merges'] = ranges;

    /* add worksheet to workbook */
    wb.SheetNames.push(ws_name);
    wb.Sheets[ws_name] = ws;

    var wbout = XLSX.write(wb, { bookType: 'xlsx', bookSST: false, type: 'binary' });
    saveAs(new Blob([s2ab(wbout)], { type: "application/octet-stream" }), filename.replace("&gt;", "greater than ").replace("&lt;", "less than ") + ".xlsx")
}

