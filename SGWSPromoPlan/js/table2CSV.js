jQuery.fn.table2CSV = function (options) {
    var options = jQuery.extend({
        separator: ',',
        header: [],
        delivery: 'popup', // popup, value
        title: ''
    },
    options);

    var csvData = [];
    var headerArr = [];
    var el = this;

    //header
    var numCols = options.header.length;
    var tmpRow = []; // construct header avalible array

    if (numCols > 0) {
        for (var i = 0; i < numCols; i++) {
            tmpRow[tmpRow.length] = formatData(options.header[i], options.title);
        }
    } else {
        $(el).filter(':visible').find('th').each(function () {
            if ($(this).css('display') != 'none') tmpRow[tmpRow.length] = formatData($(this).html(), options.title);
        });
    }
    headercount = 1
    row2CSV(tmpRow);

    // actual data
    $(el).find('tr').each(function () {
        var tmpRow = [];
        $(this).filter(':visible').find('td').each(function () {
            if ($(this).css('display') != 'none') tmpRow[tmpRow.length] = formatData($(this).html(), options.title);
        });
        row2CSV(tmpRow);
    });
    if (options.delivery == 'popup') {
        var mydata = csvData.join('\n');
        return popup(mydata);
    } else {
        var mydata = csvData.join('\n');
        return mydata;
    }

    function row2CSV(tmpRow) {
        var tmp = tmpRow.join('') // to remove any blank rows
    
        if (tmpRow.length > 0 && tmp != '') {
            var mystr = tmpRow.join(options.separator);
            csvData[csvData.length] = mystr;
        }
    }

    function formatData(input, titleID) {
        var output = "";
        var headers = ['Store', 'Is HotSeller', 'Category', 'Vendor', 'Vendor ID', 'Style ID', 'Color ID', 'Description', 'Product Image', 'Action Taken', 'Add To Hotseller'];

        var Last_4_week_CC_headers = ['Store', 'Category', 'Target Met', 'Target Missed'];

        var present_In_Th = false;

        if (titleID == "divVSCCDisplayTitle") {
            if (input.toString().indexOf('<span class="filter_column filter_select">') >= 0) {
                if (parseInt(headercount) == 1)
                    output = headers[0];
                else if (parseInt(headercount) == 2)
                    output = headers[1];
                else if (parseInt(headercount) == 3)
                    output = headers[2];
                else if (parseInt(headercount) == 4)
                    output = headers[3];
                else if (parseInt(headercount) == 5)
                    output = headers[4];
                else if (parseInt(headercount) == 6)
                    output = headers[5];
                else if (parseInt(headercount) == 7)
                    output = headers[6];
                else if (parseInt(headercount) == 8)
                    output = headers[7];
                else if (parseInt(headercount) == 9)
                    output = headers[8];
                else if (parseInt(headercount) == 10)
                    output = headers[9];
                else if (parseInt(headercount) == 11)
                    output = headers[10];

                headercount++;

                present_In_Th = true;
            }
        }
        else if (titleID == "divCycleCount_Last4WeeksPerformance_Title") {

            if (input.toString().indexOf('<span class="filter_column filter_select">') >= 0) {
                if (parseInt(headercount) == 1)
                    output = Last_4_week_CC_headers[0];
                else if (parseInt(headercount) == 2)
                    output = Last_4_week_CC_headers[1];
                else if (parseInt(headercount) == 3)
                    output = Last_4_week_CC_headers[2];
                else if (parseInt(headercount) == 4)
                    output = Last_4_week_CC_headers[3];

                headercount++;

                present_In_Th = true;
            }
        }
        else if (titleID == "divCycleCountUserRanking_Title") {

            if (input.toString().indexOf('<span class="filter_column filter_select">') >= 0) {
                output = $(input).find('select option:first-child').html()
                present_In_Th = true;
            }
        }

        if (present_In_Th == false) {
            if (input.toString().indexOf('<img src="images/incomplete.png"') >= 0) {
                output = "No";
            }
            else if (input.toString().indexOf('<span style=\"display:none"\>.</span><img src="images/complete.png"') >= 0) {
                output = "Yes";
            }
            else if (input.toString().indexOf('<span style="display:none;">hotseller</span>') >= 0) {
                output = "Yes";
            }
            else if (input.toString().indexOf('Regular') >= 0) {
                output = "No";
            }
            else {

                if ((input.toString().search('<img') != 0)) {
                    // replace " with â€œ
                    var regexp = new RegExp(/["]/g);
                    output = input.replace(regexp, "â€œ");
                    //HTML
                    var regexp = new RegExp(/\<[^\<]+\>/g);
                    output = output.replace(regexp, "");

                    output = output.replace(/&nbsp;/g, "");
                }
                else {
                    if ($(input).attr('alturl') != null)
                        output = $(input).attr('alturl');
                    else
                        output = $(input).attr('src');
                }
            }
        }
        if (output == "") return '';
        return '"' + output + '"';
    }
    function popup(data) {
        var generator = window.open('', 'csv', 'height=400,width=600');
        generator.document.write('<html><head><title>CSV</title>');
        generator.document.write('</head><body >');
        generator.document.write('<textArea cols=70 rows=15 wrap="off" >');
        generator.document.write(data);
        generator.document.write('</textArea>');
        generator.document.write('</body></html>');
        generator.document.close();
        return true;
    }
};

function download(strData, strFileName, strMimeType) {
    var D = document,
        a = D.createElement("a");
    strMimeType = strMimeType || "application/octet-stream";


    if (navigator.msSaveBlob) { // IE10
        return navigator.msSaveBlob(new Blob([strData], { type: strMimeType }), strFileName);
    } /* end if(navigator.msSaveBlob) */


    if ('download' in a) { //html5 A[download]
        a.href = "data:" + strMimeType + "," + encodeURIComponent(strData);
        a.setAttribute("download", strFileName);
        a.innerHTML = "downloading...";
        D.body.appendChild(a);
        setTimeout(function () {
            a.click();
            D.body.removeChild(a);
        }, 66);
        return true;
    } /* end if('download' in a) */


    //do iframe dataURL download (old ch+FF):
    var f = D.createElement("iframe");
    D.body.appendChild(f);
    f.src = "data:" + strMimeType + "," + encodeURIComponent(strData);

    setTimeout(function () {
        D.body.removeChild(f);
    }, 333);
    return true;
} /* end download() */