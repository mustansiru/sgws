<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ExpenseData.aspx.cs" Inherits="ExpenseData" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .ag-fresh .ag-header-cell-label {
            float: none !important;
            width: auto !important;
            justify-content: center;
        }

        .ag-fresh .ag-header-cell-menu-button {
            position: absolute;
            float: none;
        }

        .dropdown-menu > .active > a, .dropdown-menu > .active > a:hover, .dropdown-menu > .active > a:focus {
            background-color: #428bca !important;
        }
        /*button.multiselect.dropdown-toggle.btn.btn-default{width:240px !important;}*/
        .ag-header-cell-label {
            justify-content: center;
        }

        ul.multiselect-container {
            width: 100% !important;
        }

        .dropdown-menu {
            width: 100% !important;
        }

        .multiselect-container > li > a > label.checkbox {
            width: 100% !important;
        }

        .btn-group {
            width: 100% !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="css/jquery.fileupload.css" rel="stylesheet" />
    <link href="css/jquery.fileupload-ui.css" rel="stylesheet" />
    <script src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.noStyle.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-grid.css" />
    <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-theme-balham.css" />

    <div class="row" id="divfilter">
        <div class="col-md-12 nopadding">
            <div class="spacer20px"></div>
            <div class="form-group clearfix">

                <div class="col-md-2 width-auto">
                    <div class="form-group">
                        <label class="margintop-7px">SGWS Calendar</label>
                    </div>
                </div>
                <div class="col-md-2 nopadding-left width-auto">
                    <div class="form-group">
                        <asp:DropDownList ID="ddlSGWSCalendar" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:DropDownList>
                        <%--onchange="return GetExpenseDataByYear();"--%>
                    </div>
                </div>
                <div class="col-md-1">
                    <div class="form-group">
                        <label class="margintop-7px">Province</label>
                    </div>
                </div>
                <div class="col-md-3 nopadding-left">
                    <div class="form-group">
                        <asp:DropDownList ID="ddlProvince" ClientIDMode="Static" multiple="multiple" CssClass="multiselect" runat="server"></asp:DropDownList>
                        <asp:HiddenField ID="hdnProvince" ClientIDMode="Static" runat="server" />
                    </div>
                </div>
                <div class="col-md-1">
                    <div class="form-group">
                        <label class="margintop-7px">Supplier</label>
                    </div>
                </div>
                <div class="col-md-3 nopadding-left">
                    <div class="form-group">
                        <asp:DropDownList ID="ddlSuppliers" ClientIDMode="Static" multiple="multiple" CssClass="multiselect" runat="server"></asp:DropDownList>
                        <asp:HiddenField ID="hdnSuppliers" ClientIDMode="Static" runat="server" />
                    </div>
                </div>
                <div class="col-md-1">
                    <div class="form-group">
                        <button id="btnSearch" type="button" class="btn btn-primary" onclick="return GetExpenseData();">
                            Search
                        </button>
                    </div>
                </div>
            </div>
            <div class="form-group clearfix">
            </div>

        </div>
        <div class="col-md-12">
            <div class="form-group">
                <%--<asp:Button ID="btnExport" Text="Export" runat="server" OnClick="ExportExcel_Click" CssClass="btn btn-primary" />--%>
                <div id="myGrid" class="table-responsive ag-theme-balham text-center" style="height: 400px; width: 100%;">
                </div>
                <div id="totalFooter" style="display: none; float: right;">
                </div>
                <br />
                <span class="btn btn-success fileinput-button">
                    <i class="glyphicon glyphicon-plus"></i>
                    <span>Select file...</span>
                    <!-- The file input field used as target for the file upload widget -->
                    <input id="fileupload" type="file" name="files[]" />
                </span>

                <!-- The global progress bar -->
                <div id="progress" class="progress">
                    <div class="progress-bar progress-bar-success"></div>
                </div>
                <!-- The container for the uploaded files -->
                <div id="files" class="files"></div>
                <div id="parseError" style="height: 250px; display: none; overflow-y: scroll;">
                </div>
                <div class="clearfix">
                </div>
            </div>
        </div>
    </div>

    <div id="dvExpensePopup" style="display: none; top: 30px;" class="modal modal-fade in">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header" style="background: #71777d; color: #fff;">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" style="font-size: 13px;" id="ModalTitle"></h4>
                </div>
                <div class="modal-body" id="modalBody">
                    <%--<div class="col-md-12">
                        <div class="col-md-2">Amount</div>
                        <div class="col-md-2"><label id="spAmount"></label></div>
                    </div>--%>
                </div>
            </div>
        </div>
    </div>

    <link href="dist/css/bootstrap-multiselect.css" rel="stylesheet" />
    <script src="js/jquery.ui.widget.js"></script>
    <script src="js/jquery.fileupload.js"></script>
    <script src="dist/bootstrap-multiselect.js"></script>
    <script>
        /*jslint unparam: true */
        /*global window, $ */
        $(function () {
            'use strict';

            $('#fileupload').fileupload({
                url: '../Handlers/FileUploadHandler.ashx',
                dataType: 'json',
                done: function (e, data) {
                    $.each(data.result.files, function (index, file) {
                        //$('<p/>').text(file.name).appendTo('#files');
                        $('#files').text('File imported!. Now processing file');
                        $('#divLoading').show();
                        GetFileData(file.name);
                    });

                },
                error: function (jqXHR, textStatus, errorThrown) {
                    ShowLoginExpired(jqXHR, textStatus, errorThrown);
                },
                progressall: function (e, data) {
                    var progress = parseInt(data.loaded / data.total * 100, 10);
                    $('#progress .progress-bar').css(
                        'width',
                        progress + '%'
                    );
                }
            }).prop('disabled', !$.support.fileInput)
                .parent().addClass($.support.fileInput ? undefined : 'disabled');

            FillDropdowns();

        });

        function FillDropdowns() {
            $("#ddlSuppliers").multiselect(
                {
                    maxHeight: 200,
                    numberDisplayed: 1,
                    //includeSelectAllOption: true,
                    buttonWidth: '100%',
                    onChange: function (option, checked) {
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
                    }
                }
            );

            $("#ddlProvince").multiselect(
                {
                    maxHeight: 200,
                    numberDisplayed: 1,
                    buttonWidth: '100%',//'260',
                    onChange: function (option, checked) {
                        var selected = [];
                        $('#ddlProvince option:selected').each(function () {
                            selected.push([$(this).val(), $(this).data('order')]);
                        });

                        var text = '';
                        for (var i = 0; i < selected.length; i++) {
                            text += selected[i][0] + ',';
                        }
                        text = text.substring(0, text.length - 1);

                        $("#hdnProvince").val(text);
                    }
                }
            );

            var dataarray = $("#hdnProvince").val().split(",");
            $("#ddlProvince").val(dataarray);
            $("#ddlProvince").multiselect("refresh");

            dataarray = '';
            dataarray = $("#hdnSuppliers").val().split(",");
            //alert(dataarray);
            $("#ddlSuppliers").val(dataarray);
            $("#ddlSuppliers").multiselect("refresh");
        }

        function GetFileData(fileValue) {
            var year = parseInt($("#<%= ddlSGWSCalendar.ClientID%>").val());
            var province = $('#hdnProvince').val();
            var suppliers = $('#hdnSuppliers').val();
            $.ajax({
                method: "POST",
                url: "/ExpenseData.aspx/GetFileData",
                contentType: "application/json; charset=utf-8",
                data: '{ fileName: "' + fileValue + '",year: ' + year + 'province: "' + province + '"suppliers: "' + suppliers + '"}',
                //async : false,
                success: function (jsonData) {
                    if (jsonData != null && jsonData.d.length > 0) {

                        var fData = $.parseJSON(jsonData.d);
                        //debugger;
                        BindGrid(JSON.stringify(fData.jsonData));
                        //BindGrid(fData.jsonData);
                        //debugger;
                        //if (fData.ErrorList.length > 0) {
                        //    $('#parseError').show();
                        //    $('#parseError').html('<h2>Data Parse Error</h2><table class="blueTable"><thead><tr><th>GID</th><th>Column</th><th>Value</th><th>Description</th></tr></thead>' + fData.ErrorList + '</table>');
                        //}
                        //else {
                        //    $('#parseError').hide();
                        //}
                    }
                    else {
                        bootbox.alert({
                            message: "Some technical error!",
                            size: 'small'
                        });

                    }

                    $('#files').text('File data imported.');
                    $('#divLoading').hide();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    $('#divLoading').hide();
                }
            });

            return false;
        }

    </script>
    <script>

        // specify the columns
        var columnDefs = [
            { headerName: "Record", field: "Record", sortable: true, filter: true, width: 80 },
            { headerName: "Month", field: "Month", sortable: true, filter: true, width: 80 },
            { headerName: "Date", field: "Date", sortable: true, filter: true, width: 100 },
            { headerName: "Province", field: "Province", sortable: true, filter: true, width: 80 },
           // { headerName: "ExpenseType", field: "ExpenseType", sortable: true, filter: true, width: 130 },
            { headerName: "InvoiceNo", field: "InvoiceNo", sortable: true, filter: true, width: 130 },
            { headerName: "Vendor", field: "Vendor", sortable: true, filter: true, width: 130 },
            { headerName: "InvoiceDescription", field: "InvoiceDescription", sortable: true, filter: true },
            { headerName: "Employee", field: "Employee", sortable: true, filter: true },
            { headerName: "Supplier", field: "SupplierName", sortable: true, filter: true },
            { headerName: "Brand", field: "BrandName", sortable: true, filter: true },
            { headerName: "Program Type", field: "ProgramType", sortable: true, filter: true },
            { headerName: "Supplier Vendor Name", field: "SupplierVendorName", sortable: true, filter: true },
            { headerName: "Remy Classification", field: "RemyClassification", sortable: true, filter: true },
            { headerName: "Patron GL Account", field: "Patron_GL_Account", sortable: true, filter: true },
            { headerName: "Grant Applicable", field: "Grant_Applicable", sortable: true, filter: true },
            { headerName: "Supplier Coding", field: "Supplier_Coding", sortable: true, filter: true },
            { headerName: "Amount Net", field: "Amount_Net", sortable: true, filter: true, cellClass: 'text-right' },
            { headerName: "Tax", field: "Tax", sortable: true, filter: true, cellClass: 'text-right' },
            { headerName: "Total", field: "Total", sortable: true, filter: true, cellClass: 'text-right' },
            { headerName: "BillBack", field: "Bill_Back", sortable: true, filter: true },
            { headerName: "A&P or Structure", field: "IsA_P", sortable: true, filter: true }
        ];

        var eGridDiv = document.querySelector('#myGrid');
        var gridOptions;

        var gridOptions = {
            columnDefs: columnDefs,
            onRowDoubleClicked: ShowRowDetail,
            groupSelectsChildren: true,
            OnRowClicked: ShowRowDetail,
            rowSelection: 'multiple',
            rowData: []
        };

        new agGrid.Grid(eGridDiv, gridOptions);

        function BindGrid(fileData) {
            gridOptions.api.setRowData(JSON.parse(fileData));
            $('#totalFooter').html('<b>Total: </b>' + gridOptions.api.getModel().getRowCount());
            $('#totalFooter').show();
        }

        $(document).ready(function () {
            GetExpenseData();//GetExpenseDataByYear();//GetExpenseData(0);
        });

        function ShowRowDetail(row) {
            var strVal = "<tr><td class='width20'><b>Record</b></td><td>" + row.data.Record + "</td></tr>";
            strVal = strVal + "<tr><td class='width20'><b>Amount</b></td><td>" + row.data.Amount_Net + "</td></tr>";
            strVal = strVal + "<tr><td class='width20'><b>Tax</b></td><td>" + row.data.Tax + "</td></tr>";
            strVal = strVal + "<tr><td class='width20'><b>Total</b></td><td>" + row.data.Total + "</td></tr>";

            strVal = '<table class="table table-condensed table-bordered table-striped">' + strVal + '</table>';

            $('#ModalTitle').text('Expenses');
            $('#modalBody').html(strVal);
            $('#dvExpensePopup').modal('toggle');
        }

        function GetExpenseData() {
            var year = parseInt($("#<%= ddlSGWSCalendar.ClientID%>").val());
            var province = $('#hdnProvince').val();
            var suppliers = $('#hdnSuppliers').val();
            if (year > 0) {
                $('#divLoading').show();
                $.ajax({
                    method: "GET",
                    url: "/ExpenseData.aspx/GetExpenseData?year=" + year + "&province='" + province + "'&suppliers='" + suppliers + "'",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data != null) {
                            BindGrid(data.d);
                        }
                        else {
                            alert('Error');
                        }
                        $('#divLoading').hide();
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        $('#divLoading').hide();
                    }
                });
            }
        }
    </script>
</asp:Content>

