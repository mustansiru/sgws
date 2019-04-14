<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ImportProgram.aspx.cs" Inherits="ImportProgram" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="css/jquery.fileupload.css" rel="stylesheet" />
    <link href="css/jquery.fileupload-ui.css" rel="stylesheet" />
    <script src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.noStyle.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-grid.css" />
    <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-theme-balham.css" />

    <div class="row" id="divfilter">
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

    <script src="js/jquery.ui.widget.js"></script>
    <script src="js/jquery.fileupload.js"></script>
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
        });

        function GetFileData(fileValue) {
            
            $.ajax({
                method: "POST",
                url: "/ImportProgram.aspx/GetFileData",
                contentType: "application/json; charset=utf-8",
                data: '{ fileName: "' + fileValue + '"}',
                success: function (jsonData) {
                    if (jsonData != null && jsonData.d.length > 0) {
                        //alert(jsonData.d);
                        //var fData = $.parseJSON(jsonData.d);
                        //alert(fData.jsonData);
                        //BindGrid(fData.jsonData);
                        BindGrid(jsonData.d);
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
            { headerName: "ProvinceCode", field: "ProvinceCode", sortable: true, filter: true, width: 80 },
            { headerName: "SGWS_Calendar_Year", field: "SGWS_Calendar_Year", sortable: true, filter: true, width: 80 },
            { headerName: "SGWS_Calendar_Period", field: "SGWS_Calendar_Period", sortable: true, filter: true, width: 100 },
            { headerName: "Liquor_Board_Period", field: "Liquor_Board_Period", sortable: true, filter: true, width: 80 },
            { headerName: "Start_Date", field: "Start_Date", sortable: true, filter: true, width: 130 },
            { headerName: "End_Date", field: "End_Date", sortable: true, filter: true, width: 130 },
            { headerName: "GID", field: "GID", sortable: true, filter: true },
            { headerName: "Is_SKU_Brand", field: "Is_SKU_Brand", sortable: true, filter: true },
            { headerName: "CSPC", field: "CSPC", sortable: true, filter: true },
            { headerName: "ProgramType", field: "ProgramType", sortable: true, filter: true },
            { headerName: "Comments", field: "Comments", sortable: true, filter: true },
            { headerName: "ATL_BTL", field: "ATL_BTL", sortable: true, filter: true },
            { headerName: "Program_Status", field: "Program_Status", sortable: true, filter: true },
            { headerName: "Depth", field: "Depth", sortable: true, filter: true },
            { headerName: "ForecastCaseSalesBase", field: "ForecastCaseSalesBase", sortable: true, filter: true },
            { headerName: "ForecastCaseSalesLift", field: "ForecastCaseSalesLift", sortable: true, filter: true },
            { headerName: "ForecastTotalCaseSalesPhysCs", field: "ForecastTotalCaseSalesPhysCs", sortable: true, filter: true, cellClass: 'text-right' },
            { headerName: "ForecastTotalCaseSales9LCsConverted", field: "ForecastTotalCaseSales9LCsConverted", sortable: true, filter: true, cellClass: 'text-right' },
            { headerName: "VariableCostPerCase", field: "VariableCostPerCase", sortable: true, filter: true, cellClass: 'text-right' },
            { headerName: "UpforntFees_LTO_BAM", field: "UpforntFees_LTO_BAM", sortable: true, filter: true },
            { headerName: "RedemptionBAM", field: "RedemptionBAM", sortable: true, filter: true },
            { headerName: "SpendQuantity", field: "SpendQuantity", sortable: true, filter: true },
            { headerName: "SpendPerQuantity", field: "SpendPerQuantity", sortable: true, filter: true },
            { headerName: "OtherFixedCost", field: "OtherFixedCost", sortable: true, filter: true },
            { headerName: "TotalProgramSpend", field: "TotalProgramSpend", sortable: true, filter: true },
            { headerName: "Actual_Spend", field: "Actual_Spend", sortable: true, filter: true },
            { headerName: "Actual_Volume", field: "Actual_Volume", sortable: true, filter: true },
            { headerName: "UniqueID", field: "UniqueID", sortable: true, filter: true }
        ];

        var eGridDiv = document.querySelector('#myGrid');
        var gridOptions;

        var gridOptions = {
            columnDefs: columnDefs,
            onRowDoubleClicked: ShowRowDetail,
            groupSelectsChildren: true,
            //OnRowClicked: ShowRowDetail,
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
            GetProgramData();
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

        function GetProgramData() {
            $('#divLoading').show();
            $.ajax({
                method: "GET",
                url: "/ExpenseData.aspx/GetExpenseData",
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
    </script>
</asp:Content>

