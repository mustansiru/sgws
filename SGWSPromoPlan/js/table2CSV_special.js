(function (window, undefined) {
    window.T2CSV = function (table) {
        if (!(table instanceof window.HTMLTableElement)) {
            throw new window.TypeError('A <table> element is required, instead ' + table + ' was passed');
        }

        var tr, thead, cols, tfoot, csv = {
            header: '',
            data: [],
            footer: '',
            string: ''
        },
            prop = (table.innerText === undefined ? 'textContent' : 'innerText'),
            setVars = function () {
                var elements = table.getElementsByTagName('tr');

                if (elements.length < 1) {
                    throw new window.RangeError('At least 1 <tr> element is required, you have 0 on your <table>.');
                }

                tr = Array.prototype.slice.call(elements, 1);
                thead = elements[0];
                cols = thead.children.length;
                elements = null; //free memory
                csv = {
                    header: '',
                    data: [],
                    footer: '',
                    string: ''
                };
            },
            addSlashes = function (data) {
                return data.replace(/([\\"])/g, '\\$1');
            },
            render = {
                header: function () {
                    if (!(thead.children[0] instanceof window.HTMLTableCellElement)) {
                        throw new window.RangeError('At least 1 <tr> element with 1 <td> or <th> is required.');
                    }

                    for (var i = 0, children = thead.children, l = children.length, tmp = []; i < l; i++) {
                        tmp[tmp.length] = '"' + addSlashes(children[i][prop]) + '"';
                    }
                    children = null; //free memory
                    return csv.header = tmp;
                },
                data: function () {

                    if (!tr.length) {
                        return '';
                    }

                    for (var i = 0, l = tr.length, tmp = [], tfoot = false; i < l; i++) {
                        if (!tfoot && tr[i].parentNode.tagName == 'TFOOT') {
                            tfoot = tr[i];
                            continue;
                        }
                        csv.data[tmp.length] = tmp[tmp.length] = render.row(tr[i]);
                    }

                    if (tfoot) {
                        csv.footer = tmp[tmp.length] = render.row(tfoot);
                    }

                    return tmp.join('\r\n');
                },
                row: function (tr) {
                    var td = tr.getElementsByTagName('td');

                    if (!td.length) {
                        td = tr.getElementsByTagName('th');
                    }

                    for (var i = 0, tmp = []; i < cols; i++) {
                        tmp[i] = td[i] ? '"' + addSlashes(td[i][prop]) + '"' : '""';
                    }
                    return tmp + '';
                }
            };

        setVars();

        return {
            toString: function () {
                if (csv.string) {
                    return csv.string;
                }

                return csv.string = [render.header(), render.data()].join('\r\n');
            },
            valueOf: function () { return this.toString(); },
            refresh: function () {
                setVars();
            },
            getHeader: function () {
                return csv.header;
            },
            getFooter: function () {
                return csv.footer;
            },
            getRows: function () {
                return csv.data;
            },
            getRow: function (row) {
                return csv.data[row >> 0];
            }
        };

    }

})(function () { }.constructor('return this')());