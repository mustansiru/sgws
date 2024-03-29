﻿/*!
 FixedHeader 3.0.0
 Â©2009-2015 SpryMedia Ltd - datatables.net/license
*/
(function (h, j) {
    var g = function (e, i) {
        var g = 0, f = function (b, a) {
            if (!(this instanceof f)) throw "FixedHeader must be initialised with the 'new' keyword."; !0 === a && (a = {}); b = new i.Api(b); this.c = e.extend(!0, {}, f.defaults, a); this.s = { dt: b, position: { theadTop: 0, tbodyTop: 0, tfootTop: 0, tfootBottom: 0, width: 0, left: 0, tfootHeight: 0, theadHeight: 0, windowHeight: e(h).height(), visible: !0 }, headerMode: null, footerMode: null, namespace: ".dtfc" + g++ }; this.dom = {
                floatingHeader: null, thead: e(b.table().header()), tbody: e(b.table().body()),
                tfoot: e(b.table().footer()), header: { host: null, floating: null, placeholder: null }, footer: { host: null, floating: null, placeholder: null }
            }; this.dom.header.host = this.dom.thead.parent(); this.dom.footer.host = this.dom.tfoot.parent(); var c = b.settings()[0]; if (c._fixedHeader) throw "FixedHeader already initialised on table " + c.nTable.id; c._fixedHeader = this; this._constructor()
        }; f.prototype = {
            update: function () { this._positions(); this._scroll(!0) }, _constructor: function () {
                var b = this, a = this.s.dt; e(h).on("scroll" + this.s.namespace,
                function () { b._scroll() }).on("resize" + this.s.namespace, function () { b.s.position.windowHeight = e(h).height(); b._positions(); b._scroll(!0) }); a.on("column-reorder.dt.dtfc column-visibility.dt.dtfc", function () { b._positions(); b._scroll(!0) }).on("draw.dtfc", function () { b._positions(); b._scroll() }); a.on("destroy.dtfc", function () { a.off(".dtfc"); e(h).off(this.s.namespace) }); this._positions(); this._scroll()
            }, _clone: function (b, a) {
                var c = this.s.dt, d = this.dom[b], k = "header" === b ? this.dom.thead : this.dom.tfoot; !a && d.floating ?
                d.floating.removeClass("fixedHeader-floating fixedHeader-locked") : (d.floating && (d.placeholder.remove(), d.floating.children().detach(), d.floating.remove()), d.floating = e(c.table().node().cloneNode(!1)).removeAttr("id").append(k).appendTo("body"), d.placeholder = k.clone(!1), d.host.append(d.placeholder), "footer" === b && this._footerMatch(d.placeholder, d.floating))
            }, _footerMatch: function (b, a) {
                var c = function (d) { var c = e(d, b).map(function () { return e(this).width() }).toArray(); e(d, a).each(function (a) { e(this).width(c[a]) }) };
                c("th"); c("td")
            }, _footerUnsize: function () { var b = this.dom.footer.floating; b && e("th, td", b).css("width", "") }, _modeChange: function (b, a, c) {
                var d = this.dom[a], e = this.s.position; "in-place" === b ? (d.placeholder && (d.placeholder.remove(), d.placeholder = null), d.host.append("header" === a ? this.dom.thead : this.dom.tfoot), d.floating && (d.floating.remove(), d.floating = null), "footer" === a && this._footerUnsize()) : "in" === b ? (this._clone(a, c), d.floating.addClass("fixedHeader-floating").css("header" === a ? "top" : "bottom", this.c[a +
                "Offset"]).css("left", e.left + "px").css("width", e.width + "px"), "footer" === a && d.floating.css("top", "")) : "below" === b ? (this._clone(a, c), d.floating.addClass("fixedHeader-locked").css("top", e.tfootTop - e.theadHeight).css("left", e.left + "px").css("width", e.width + "px")) : "above" === b && (this._clone(a, c), d.floating.addClass("fixedHeader-locked").css("top", e.tbodyTop).css("left", e.left + "px").css("width", e.width + "px")); this.s[a + "Mode"] = b
            }, _positions: function () {
                var b = this.s.dt.table(), a = this.s.position, c = this.dom,
                b = e(b.node()), d = b.children("thead"), f = b.children("tfoot"), c = c.tbody; a.visible = b.is(":visible"); a.width = b.outerWidth(); a.left = b.offset().left; a.theadTop = d.offset().top; a.tbodyTop = c.offset().top; a.theadHeight = a.tbodyTop - a.theadTop; f.length ? (a.tfootTop = f.offset().top, a.tfootBottom = a.tfootTop + f.outerHeight(), a.tfootHeight = a.tfootBottom - a.tfootTop) : (a.tfootTop = a.tbodyTop + c.outerHeight(), a.tfootBottom = a.tfootTop, a.tfootHeight = a.tfootTop)
            }, _scroll: function (b) {
                var a = e(j).scrollTop(), c = this.s.position, d; this.c.header &&
                (d = !c.visible || a <= c.theadTop - this.c.headerOffset ? "in-place" : a <= c.tfootTop - c.theadHeight - this.c.headerOffset ? "in" : "below", (b || d !== this.s.headerMode) && this._modeChange(d, "header", b)); this.c.footer && this.dom.tfoot.length && (a = !c.visible || a + c.windowHeight >= c.tfootBottom + this.c.footerOffset ? "in-place" : c.windowHeight + a > c.tbodyTop + c.tfootHeight + this.c.footerOffset ? "in" : "above", (b || a !== this.s.footerMode) && this._modeChange(a, "footer", b))
            }
        }; f.version = "3.0.0"; f.defaults = { header: !0, footer: !1, headerOffset: 0, footerOffset: 0 };
        e.fn.dataTable.FixedHeader = f; e.fn.DataTable.FixedHeader = f; e(j).on("init.dt.dtb", function (b, a) { if ("dt" === b.namespace) { var c = a.oInit.fixedHeader || i.defaults.fixedHeader; c && !a._buttons && new f(a, c) } }); i.Api.register("fixedHeader()", function () { }); i.Api.register("fixedHeader.adjust()", function () { return this.iterator("table", function (b) { (b = b._fixedHeader) && b.update() }) }); return f
    }; "function" === typeof define && define.amd ? define(["jquery", "datatables"], g) : "object" === typeof exports ? g(require("jquery"), require("datatables")) :
    jQuery && !jQuery.fn.dataTable.FixedHeader && g(jQuery, jQuery.fn.dataTable)
})(window, document);
