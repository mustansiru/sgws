<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="RegionalView2.aspx.cs" Inherits="RegionalView" %>

<%@ Register Src="~/AllocateExpenses.ascx" TagName="AllocateExpenses" TagPrefix="ucAllocateExpenses" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
   <link href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" rel="stylesheet" />
   <%--  <script type="text/javascript" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>--%>
    <script type="text/javascript" src="js/nhpup.js"></script>
    <%--<script type="text/javascript" src="js/CommonFunctions.js"></script>--%>
    <%--<script type="text/javascript" src="js/program.js"></script>--%>

    <style>
        #pup {
            position: absolute;
            z-index: 200; /* aaaalways on top*/
            padding: 2px;
            margin-left: 10px;
            margin-top: 5px;
            /*width: 150px;*/
            border: 1px solid #dddddd;
            background-color: #ffffff;
            color: #333333;
            font-size: 0.95em;
            text-align: left
        }

        .hoverTable {
            text-align: left !important;
            border: 1px solid #dddddd !important;
            margin: 4px !important;
            padding: 4px !important;
            border-radius: 2 !important;
        }

        .hoverAltRow {
            border: 1px solid #dddddd !important;
            background-color: #f1f1f1 !important;
        }

        .hoverField {
            text-align: right !important;
            padding: 2px !important;
        }

        .dvprogramlistingtablecontainer table td, .dvprogramlistingtablecontainer th {
            font-family: 'Open Sans', helvetica, arial, sans-serif;
            font-size: 0.95em !important;
            text-align: center !important;
        }

        .dvprogramlistingtablecontainer .dataTables_scrollHeadInner table th {
            text-align: center !important;
        }

        .row-bg td {
            background-color: none !important;
            font-weight: bold;
            border-bottom: 1px solid #428bca !important;
        }

        .right {
            text-align: right;
            margin-right: 1em;
        }

        .left {
            text-align: left !important;
            /*margin-left: 1em;*/
        }

        .text-right {
            text-align: right !important;
        }

        .linkAllocateExpenses {
            text-decoration: underline;
        }

        .size_Period {
            width: 110px !important;
        }

        .size_StartDate {
            width: 80px !important;
        }

        .size_EndDate {
            width: 70px !important;
        }

        .size_ATLBTL {
            width: 60px !important;
        }

        .size_Activity {
            width: 70px !important;
        }

        .size_IsSkuBased {
            width: 100px !important;
        }

        .size_PType {
            width: 200px !important;
        }

        .size_ProgramDescription {
            width: 250px !important;
            word-wrap: break-word;
        }

        .size_AlternateName {
            width: 250px !important;
            word-wrap: break-word;
        }

        .size_StatusCode {
            width: 130px !important;
        }

        .size_ProgramSpend {
            width: 88px !important;
            text-align: right !important;
        }

        .size_ActualSpend {
            width: 88px !important;
            text-align: right !important;
        }

        .dvprogramlistingtablecontainer table.dataTable.compact thead th, .dvprogramlistingtablecontainer table.dataTable.compact thead td {
            padding-top: 4px;
            padding-right: 5px !important;
            padding-bottom: 4px;
            padding-left: 4px;
        }

        .dvprogramlistingtablecontainer table.dataTable.nowrap th, .dvprogramlistingtablecontainer table.dataTable.nowrap td {
            /*word-wrap: break-word !important;*/
            white-space: normal !important;
        }

        .dropdown-menu > .active > a, .dropdown-menu > .active > a:hover, .dropdown-menu > .active > a:focus {
            color: #fff;
            text-decoration: none;
            background-color: #428bca !important;
            outline: 0;
        }

        .dvprogramlistingtablecontainer ul .active {
            border-bottom: none !important;
        }

        .dropdown-menu > a {
            text-decoration: none !important;
        }

        .dvprogramlistingtablecontainer table.blueTable {
            /*border: 1px solid #1C6EA4;*/
            background-color: #EEEEEE;
            width: 100%;
            text-align: left;
            border-collapse: collapse;
        }

            .dvprogramlistingtablecontainer table.blueTable td, .dvprogramlistingtablecontainer table.blueTable th {
                padding: 3px 2px;
            }

            .dvprogramlistingtablecontainer table.blueTable tbody td {
                font-size: 13px;
                text-align: left;
                border: 0;
            }

            /*table.blueTable tr:nth-child(even) {
                background: #EEEEEE;
            }*/

            .dvprogramlistingtablecontainer table.blueTable thead {
                background: #1C6EA4;
                background: -moz-linear-gradient(top, #5592bb 0%, #327cad 66%, #1C6EA4 100%);
                background: -webkit-linear-gradient(top, #5592bb 0%, #327cad 66%, #1C6EA4 100%);
                background: linear-gradient(to bottom, #5592bb 0%, #327cad 66%, #1C6EA4 100%);
                /*border-bottom: 1px solid #444444;*/
            }

                .dvprogramlistingtablecontainer table.blueTable thead th {
                    background: #c1b7b7;
                    font-size: 15px;
                    font-weight: bold;
                    color: #FFFFFF;
                    border-left: 0px solid #D0E4F5;
                }

                    .dvprogramlistingtablecontainer table.blueTable thead th:first-child {
                        border-left: none;
                    }

            .dvprogramlistingtablecontainer table.blueTable tfoot {
                font-size: 14px;
                font-weight: bold;
                color: #FFFFFF;
                background: #D0E4F5;
                background: -moz-linear-gradient(top, #dcebf7 0%, #d4e6f6 66%, #D0E4F5 100%);
                background: -webkit-linear-gradient(top, #dcebf7 0%, #d4e6f6 66%, #D0E4F5 100%);
                background: linear-gradient(to bottom, #dcebf7 0%, #d4e6f6 66%, #D0E4F5 100%);
                border-top: 0px solid #444444;
            }

                .dvprogramlistingtablecontainer table.blueTable tfoot td {
                    font-size: 14px;
                }

                .dvprogramlistingtablecontainer table.blueTable tfoot .links {
                    text-align: right;
                }

            .dvprogramlistingtablecontainer table.blueTable tr, .dvprogramlistingtablecontainer td {
                border: none !important;
            }

            .dvprogramlistingtablecontainer table.blueTable tfoot .links a {
                display: inline-block;
                background: #1C6EA4;
                color: #FFFFFF;
                padding: 2px 8px;
                /*border-radius: 1px;*/
            }

        .dvprogramlistingtablecontainer .rejected {
            background: #FFA500 !important;
            color: #FFFFFF;
        }

        /*.display tr, td {
            border-bottom: solid 1px !important;
        }*/

        .dvprogramlistingtablecontainer .col-md-2 {
            width: 14% !important;
        }

        .dvprogramlistingtablecontainer .multiselect-container > li > a {
            text-decoration: none !important;
        }

        .dvprogramlistingtablecontainer .modal-sm {
            width: 350px;
        }

        .dvprogramlistingtablecontainer select {
            color: black;
        }

        .dvprogramlistingtablecontainer td.compaign-control {
            background: url(../images/details_open2.png) no-repeat center left;
            padding-left: 25px !important;
            text-align: left !important;
            cursor: pointer;
        }

        .dvprogramlistingtablecontainer tr.shown td.compaign-control {
            background: url(../images/details_close2.png) no-repeat center left;
            padding-left: 25px !important;
            text-align: left !important;
            cursor: pointer;
        }

        .dvprogramlistingtablecontainer td.details-control {
            background: url(../images/details_Open.png) no-repeat center left !important;
            padding-left: 5px !important;
        }

        .dvprogramlistingtablecontainer tr.shown td.details-control {
            background: url(../images/details_close.png) no-repeat center left !important;
            padding-left: 5px !important;
        }

        .dvprogramlistingtablecontainer .table-program-spending {
            border-collapse: collapse !important;
            width: 600px !important;
            padding: 4px !important;
            margin: 4px !important;
            text-align: left !important;
            border: 1px solid #c1b7b7 !important;
            text-align: left !important;
        }

        .pull-right {
            float: right !important;
        }
         .size_Action {
            width: 160px !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="dvprogramlistingtablecontainer">
    <div class="col-md-12">
        <div class="col-md-5"></div>
        <div class="col-md-7" align="right">
            
            </div>
        </div>

    <div class="row">
        <div class="col-md-12">
        </div>
    </div>
    <div class="row" id="divfilter">
        <div class="col-md-4">
            <!-- Periods -->
            <div class="row">
            <div class="col-md-12">
                <div class="form-group clearfix">
                    <fieldset>
                        <legend>Period</legend>
                        <asp:RadioButton ID="rdoSGWSPeriod" ClientIDMode="Static" runat="server" name="rdbPeriod" GroupName="rdbPeriod" Text="SGWS" value="SGWS" Checked />
                        <asp:RadioButton ID="rdoLiquorPeriod" ClientIDMode="Static" runat="server" name="rdbPeriod" GroupName="rdbPeriod" Text="Liquor Board" value="LIQR" />
                        <asp:RadioButton ID="rdoSupplierPeriod" ClientIDMode="Static" runat="server" name="rdbPeriod" GroupName="rdbPeriod" Text="Supplier" value="SUPP" />
                    </fieldset>
                </div>
            </div>
            </div>
            <!-- Year + Province -->
            <div class="row">
                <div class="col-md-12">
            <div class="form-group clearfix">
                        <div class="row">
                            <div class="col-md-12">
                                <asp:DropDownList ID="ddlSGWSCalendar" ClientIDMode="Static" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>
                        </div>
                </div>
                    <div class="form-group clearfix">
                        <div class="row">
                            <div class="col-md-12">
                    <asp:DropDownList ID="ddlProvince" ClientIDMode="Static" runat="server" CssClass="form-control"></asp:DropDownList>
                    <asp:HiddenField ID="hdnProvince" ClientIDMode="Static" runat="server" />
                </div>
                        </div>
                    </div>
                </div>
            </div>
                </div>
                <div class="col-md-3">
            <div class="form-group clearfix">
                <div class="row">
                    <div class="col-md-12">
                    <asp:DropDownList ID="ddlSuppliers" ClientIDMode="Static" multiple="multiple" CssClass="multiselect" runat="server"></asp:DropDownList>
                    <asp:HiddenField ID="hdnSuppliers" ClientIDMode="Static" runat="server" />
                </div>
            </div>
            </div>
            <div class="form-group clearfix">
                <div class="row">
                    <div class="col-md-12">
                    <asp:DropDownList ID="ddlCategory" ClientIDMode="Static" multiple="multiple" CssClass="form-control" runat="server"></asp:DropDownList>
                    <asp:HiddenField ID="hdnCategory" ClientIDMode="Static" runat="server" />
                </div>
                </div>
                </div>
            <div class="form-group clearfix">
                <div class="row">
                    <div class="col-md-12">
                    <asp:DropDownList ID="ddlBrand" ClientIDMode="Static" multiple="multiple" CssClass="form-control" runat="server"></asp:DropDownList>
                    <asp:HiddenField ID="hdnBrand" ClientIDMode="Static" runat="server" />
                </div>
                </div>
            </div>
            <div class="form-group clearfix">
                <div class="col-md-12">
                    <button id="btnSearch" type="button" class="btn btn-primary" onclick="Search(); return false;">
                        Search
                    </button>
                </div>
            </div>
        </div>
        <div class="col-md-5">
            <div id="SummaryRollup">
                </div>
                </div>
            </div>

        <%-- <div class="col-md-12">
            <div id="SummaryRollup">

            </div>
        </div>--%>
        <div class="col-md-12">
            <hr style="border: 1px solid #c1b7b7" />
        </div>
        <div class="col-md-12">
            <div class="table-responsive" id="divprogramlistingtablecontainer">
                 <table id="tblProgramLsting" class="display responsive compact nowrap">
                    <thead>
                        <tr role="row">
                             <th>Period</th>
                            <%--<th style="visibility:hidden;display:none">Row Labels</th>--%>
                            <th>Id</th>
                            <th>Program Type</th>
                            <th>Program Description</th>
                            <th>ATL/BTL</th>
                            <th>SKU/Brand</th>
                            <th>Product Description</th>
                            <th>Status</th>
                            <th>Sum of Total Program Spend</th>
                            <th>Sum of Actual Spend</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>

    <ucAllocateExpenses:AllocateExpenses runat="server" ID="ucAllocateExpenses" />

    <link href="dist/css/bootstrap-multiselect.css" rel="stylesheet" />
    <script src="dist/bootstrap-multiselect.js"></script>
    <script>
        var tblProgramData;
        var tblCompaignData;
        // Array to track the ids of the details displayed rows
        var detailRows = [];

        $(document).ready(function () {
            $("#divprogramlistingtablecontainer").hide();
            $("#ddlSuppliers").multiselect(
                {
                    nonSelectedText: '--Suppliers--',
                    maxHeight: 200,
                    includeSelectAllOption: true,
                    enableFiltering: true,
                    enableCaseInsensitiveFiltering: true,
                    onChange: function (option, checked) {
                        SelectSupplier();
                    },
                    onSelectAll: function () {
                        SelectSupplier();
                    },
                    onDeselectAll: function () {
                        SelectSupplier();
                    }
                }
            );

            function SelectSupplier() {
                var selected = [];
                $('#ddlSuppliers option:selected').each(function () {
                    selected.push([$(this).val(), $(this).data('order')]);
                });

                var text = '';
                for (var i = 0; i < selected.length; i++) {
                    text += selected[i][0] + ',';
                }
                text = text.substring(0, text.length - 1);

                $("#hdnSuppliers").val(text);

                $.ajax({
                    method: "GET",
                    url: "RegionalView.aspx/GetBrand",
                    contentType: "application/json; charset=utf-8",
                    data: { SupplierId: "'" + $("#hdnSuppliers").val() + "'" },
                    success: function (data) {
                        if (data != null && data.d != null); {
                            var BrandArr = JSON.parse(data.d);
                            var htmlStr = '';
                            var i;

                            for (i = 0; i < BrandArr.length; i++) {
                                htmlStr = htmlStr + '<option value="' + BrandArr[i].Id + '">' + BrandArr[i].BrandName + '</option>'
                            }

                            $('#ddlBrand').empty().append(htmlStr);
                            $('#ddlBrand').multiselect('destroy');
                            $("#ddlBrand").multiselect({ maxHeight: 200 });
                            $('#ddlBrand').multiselect('rebuild');
                        }

                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        $('#divLoading').hide();
                    }
                });
            }

            //$("#ddlProvince").multiselect(
            //    {
            //        maxHeight: 200,
            //        onChange: function (option, checked) {
            //            var selected = [];
            //            $('#ddlProvince option:selected').each(function () {
            //                selected.push([$(this).val(), $(this).data('order')]);
            //            });

            //            var text = '';
            //            for (var i = 0; i < selected.length; i++) {
            //                text += selected[i][0] + ',';
            //            }
            //            text = text.substring(0, text.length - 1);

            //            $("#hdnProvince").val(text);
            //        }
            //    }
            //);

            $("#ddlBrand").multiselect(
                {
                    nonSelectedText: '--Brands--',
                    maxHeight: 200,
                    includeSelectAllOption: true,
                    enableFiltering: true,
                    enableCaseInsensitiveFiltering: true,
                    onChange: function (option, checked) {
                        var selected = [];
                        $('#ddlBrand option:selected').each(function () {
                            selected.push([$(this).val(), $(this).data('order')]);
                        });

                        var text = '';
                        for (var i = 0; i < selected.length; i++) {
                            text += selected[i][0] + ',';
                        }
                        text = text.substring(0, text.length - 1);

                        $("#hdnBrand").val(text);
                    }
                }
            );

            $("#ddlCategory").multiselect(
                {
                    nonSelectedText: '--Categories--',
                    maxHeight: 200,
                    includeSelectAllOption: true,
                    onChange: function (option, checked) {
                        SelectCategory();
                    },
                    onSelectAll: function () {
                        SelectCategory();
                    },
                    onDeselectAll: function () {
                        SelectCategory();
                    }
                }
            );

            function SelectCategory() {
                var selected = [];
                $('#ddlCategory option:selected').each(function () {
                    selected.push([$(this).val(), $(this).data('order')]);
                });

                var text = '';
                for (var i = 0; i < selected.length; i++) {
                    text += selected[i][0] + ',';
                }
                text = text.substring(0, text.length - 1);

                $("#hdnCategory").val(text);
            }

            var dataarray = $("#hdnProvince").val().split(",");
            $("#ddlProvince").val(dataarray);
            $("#ddlProvince").prop('selectedIndex', 0);
            //$("#ddlProvince").multiselect("refresh");

            dataarray = '';
            dataarray = $("#hdnSuppliers").val().split(",");
            //alert(dataarray);
            $("#ddlSuppliers").val(dataarray);
            $("#ddlSuppliers").multiselect("refresh");

            dataarray = '';
            dataarray = $("#hdnBrand").val().split(",");
            $("#ddlBrand").val(dataarray);
            $("#ddlBrand").multiselect("refresh");

            dataarray = '';
            dataarray = $("#hdnCategory").val().split(",");
            $("#ddlCategory").val(dataarray);
            $("#ddlCategory").multiselect("refresh");


            //$("#ddlSGWSCalendar").change(function () {
            //    $("#ddlLiquorBoardPeriod").val('0');
            //});

            //$("#ddlLiquorBoardPeriod").change(function () {
            //    $("#ddlSGWSCalendar").val('0');
            //});




        });

        function CompaignTable(SGWSPeriod) {

            var tblName = '#tblCompaign' + SGWSPeriod;

            tblCompaignData = $(tblName).dataTable({
                "bAutoWidth": false,
                "processing": false,
                "serverSide": false,
                columns: [
                    {
                        "className": 'compaign-control',
                        "orderable": false,
                        "defaultContent": '',
                        "sWidth": "110px"
                    },
                    { 'data': 'SuperProgramId', "sWidth": "20px", "visible": false },
                    { 'data': 'SGWS_Calendar_Period', "sWidth": "20px", "visible": false },
                    { 'data': 'LiquorBoardPeriod', "sWidth": "20px", "visible": false },
                    { 'data': 'Custom_SGWS_Period_Or_Liquor_Period', "sWidth": "20px", "visible": false },

                ],
                bInfo: false,
                paging: false,
                bLengthChange: false
            });

            $(tblName).dataTable().api().rows().every(function () {
                var tr = $(this.node());
                var row = tblCompaignData.api().row(tr);


                if (row.child.isShown()) {
                    tr.removeClass('shown');
                    row.child.hide();
                }
                else {
                    tr.addClass('shown');
                    row.child(LoadDetail(row.data())).show();
                }
            });


            tblName = '#tblCompaign' + SGWSPeriod + '_filter';

            $(tblName).hide();

            tblName = '#tblCompaign' + SGWSPeriod;
            $(tblName + ' tbody').on('click', 'tr td.compaign-control', function () {

                var tr = $(this).closest('tr');
                var row = $(tblName).dataTable().api().row(tr);
                //alert(tblName);
                //var idx = $.inArray(tr.attr('id'), detailRows);

                if (row.child.isShown()) {
                    tr.removeClass('shown');
                    row.child.hide();
                }
                else {
                    tr.addClass('shown');
                    row.child(LoadDetail(row.data())).show();
                }
            });
        }
        function JqueryDatatable() {

            $('#divLoading').show();
            $("#divprogramlistingtablecontainer").show();
            tblProgramData = $('#tblProgramLsting').dataTable({
                "ajax":
                {
                    "url": "RegionalView2.aspx/LoadData",
                    "contentType": "application/json",
                    "type": "GET",
                    "dataType": "JSON",
                    "data": function (d) {
                        return d;
                    },
                    "dataSrc": function (json) {
                        json.draw = json.d.draw;
                        json.recordsTotal = json.d.recordsTotal;
                        json.recordsFiltered = json.d.recordsFiltered;
                        json.data = json.d.data;

                        var return_data = json;
                        return return_data.data;
                    },
                    "error": function (jqXHR, textStatus, errorThrown) {
                        ShowLoginExpired(jqXHR, textStatus, errorThrown);
                    }
                },
                "search": {
                    "search": GetSearchParameters()
                },
                "bAutoWidth": true,
                "processing": true,
                "serverSide": true,
                "responsive": true,
                columns: [
                    {
                        "className": 'details-control',
                        "orderable": false,
                        //"data": 'Period',
                        "render": function (data, type, full, meta) {
                            return full.Custom_SGWS_Calendar_Period;
                        },
                        "defaultContent": '', "sWidth": "110px"

                    },
                    { 'data': 'SuperProgramId', "sWidth": "20px", "visible": false },
                    { 'data': 'No_Data', "sWidth": "200px", "bSortable": false }, // Program Type
                    { 'data': 'No_Data', "sWidth": "250px", "bSortable": false }, // Program Comment
                    { 'data': 'No_Data', "sWidth": "60px", "bSortable": false }, // ATL
                    { 'data': 'No_Data', "sWidth": "100px", "bSortable": false }, // SKU/Brand
                    { 'data': 'No_Data', "sWidth": "250px", "bSortable": false },//Prodcut Description

                    //{ 'data': 'No_Data', "sWidth": "80px", "bSortable": false },//start date
                    //{ 'data': 'No_Data', "sWidth": "70px", "bSortable": false }, // end date


                    //{ 'data': 'No_Data', "sWidth": "70px", "bSortable": false }, // Activity


                    //{ 'data': 'No_Data', "sWidth": "100px", "bSortable": false },
                    //{ 'data': 'No_Data', "sWidth": "100px", "bSortable": false },
                    { 'data': 'No_Data', "sWidth": "130px", "bSortable": false },//Status
                    { 'data': 'TotalProgramSpend', "sWidth": "100px", "bSortable": false, "className": "text-right" },//Total Program Spend
                    { 'data': 'No_Data', "sWidth": "100px", "bSortable": false, "className": "text-right" },//Actual Spend
                    { 'data': 'No_Data', "sWidth": "150px", "bSortable": false }//Allocate
                ],
                "fnDrawCallback": function (oSettings) {
                    $('#divLoading').hide();
                    $("#tblProgramLsting").dataTable().api().rows().every(function () {
                        //    var tr = $(this.node());
                        //    var row = tblProgramData.api().row(tr);
                        //    row.child(CampaignData(row.data())).show();
                        //    tr.addClass('shown');
                        //    CompaignTable(row.data().Custom_SGWS_Period_Or_Liquor_Period);
                    });
                },
                scrollX: true,
                bInfo: false,
                paging: true,
                "iDisplayLength": 6,
                "bDestroy": true,
                bLengthChange: false
            });
            $('#tblProgramLsting_filter').hide();

        }

        $("#toggle-btn").click(function () {
            $('#divLoading').show();
            JqueryDatatable();
        });

        function CampaignData(d) {
            var detailData = "";
            $.ajax({
                method: "GET",
                url: "RegionalView2.aspx/LoadCampaign",
                contentType: "application/json; charset=utf-8",
                data: { _SGWSPeriod: "'" + d.SGWS_Calendar_Period + "'", _LiquorBoardPeriod: "'" + d.LiquorBoardPeriod + "'" },
                async: false,
                success: function (data) {
                    detailData = data.d;
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //$('#divLoading').hide();
                }
            });
            return detailData;
        }

        function LoadDetail(d) {
            var detailData = "";

            $.ajax({
                method: "GET",
                url: "RegionalView2.aspx/LoadDetailData",
                contentType: "application/json; charset=utf-8",
                data: { _SGWSPeriod: "'" + d.SGWS_Calendar_Period + "'", _LiquorBoardPeriod: "'" + d.LiquorBoardPeriod + "'" },
                async: false,
                success: function (data) {
                    detailData = data.d;
                    SetAllProgramTotalSpendDetails(data.d);
                    //$('#divLoading').hide();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //$('#divLoading').hide();
                }
            });

            console.log(detailData);
            return detailData;
        }

        function SummaryRollupTable(searchPara) {
            $.ajax({
                method: "GET",
                url: "RegionalView2.aspx/GetSummaryRollup",
                contentType: "application/json; charset=utf-8",
                data: { searchParameters: "'" + searchPara + "'" },
                success: function (data) {
                    $("#SummaryRollup").html(data.d);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //$('#divLoading').hide();
                }
            });
        }

        function Search() {
            $('#divLoading').show();

            SummaryRollupTable(GetSearchParameters());

            JqueryDatatable();
            $('#tblProgramLsting tbody').on('click', 'tr td.details-control', function () {
                //debugger;
                var tr = $(this).closest('tr');
                var row = tblProgramData.api().row(tr);
                var idx = $.inArray(tr.attr('id'), detailRows);

                if (row.child.isShown()) {
                    tr.removeClass('shown');
                    row.child.hide();

                    // Remove from the 'open' array
                    detailRows.splice(idx, 1);
                }
                else {
                    tr.addClass('shown');
                    row.child(CampaignData(row.data())).show();

                    CompaignTable(row.data().Custom_SGWS_Period_Or_Liquor_Period);

                    if (idx === -1) {
                        detailRows.push(tr.attr('id'));
                    }
                }

            });

            //$('#tblProgramLsting').DataTable().search(GetSearchParameters()).draw();
        }

        function GetSearchParameters() {

            var searchPara = '';
            if ($('#ddlSGWSCalendar').val() != '0')
                searchPara = searchPara + '|SGWS_Calendar_Year:' + $('#ddlSGWSCalendar').val();
            if ($('#hdnProvince').val() != '' && $('#hdnProvince').val() != '0')
                searchPara = searchPara + '|ProvinceCode In (' + $('#ddlProvince').val() + ')';
            if ($('#ddlCategory').val() != '0' && $('#ddlCategory').val() != '')
                searchPara = searchPara + '|CategoryId In (' + $('#ddlCategory').val() + ')';
            if ($('#hdnSuppliers').val() != '' && $('#hdnSuppliers').val() != '0')
                searchPara = searchPara + '|SupplierId In (' + $('#ddlSuppliers').val() + ')';
            if ($('#ddlBrand').val() != '0' && $('#ddlBrand').val() != '')
                searchPara = searchPara + '|BrandId in (' + $('#ddlBrand').val() + ')';
            //if ($('#ddlLiquorBoardPeriod').val() != '0')
            //    searchPara = searchPara + "|FiscalYearByLiquorBoardId:'" + $('#ddlLiquorBoardPeriod').val() + "'";

            searchPara = searchPara + '|RDB:' + $("input[name='ctl00$ContentPlaceHolder1$rdbPeriod']:checked").val();
            return searchPara;
        }
        function ChangeProgramStatus(ddl) {

            var ProgramStatusId = $(ddl).val();
            var ProgramId = $(ddl).attr('prgoramid');
            $.ajax({
                method: "GET",
                url: "RegionalView.aspx/UpdateProgramStatus",
                contentType: "application/json; charset=utf-8",
                data: { programStatusId: ProgramStatusId, programId: ProgramId },
                //async: false,
                success: function (data) {
                    if (data.d = 'data') {
                        bootbox.alert({
                            message: "Program Status updated successfully!",
                            size: 'small'
                        });
                    } else {
                        bootbox.alert({
                            message: "Some technical error!",
                            size: 'small'
                        });
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //$('#divLoading').hide();
                }
            });
        }

        function GetCostBreakupByProgramType(pId, target) {
            $.ajax({
                method: 'GET',
                url: 'RegionalView2.aspx/GetCostBreakupByProgramType',
                contentType: 'application/json; charset=utf-8',
                data: { ProgramId: pId },
                success: function(data) {
                    console.log(target);
                    $('#' + target).innerHTML(data.d);
                    //$('#' + target).show();
                }
            });
        }
    </script>



</asp:Content>

