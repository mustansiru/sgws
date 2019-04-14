<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MasterSKUList.aspx.cs" Inherits="adminsection_MasterSKUList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="css/jquery.fileupload.css" rel="stylesheet" />
    <link href="css/jquery.fileupload-ui.css" rel="stylesheet" />
    <script src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.noStyle.js"></script>
    <%--<script src="https://unpkg.com/ag-grid-enterprise/dist/ag-grid-enterprise.min.noStyle.js"></script>--%>
    <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-grid.css" />
    <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-theme-balham.css" />
    <style>
        .ag-header-cell-text {
            flex: 1;
            text-align: center;
        }

        .text-center {
            text-align: center
        }

        table.blueTable {
            border: 1px solid #1C6EA4;
            background-color: #EEEEEE;
            width: 100%;
            text-align: left;
            border-collapse: collapse;
        }

            table.blueTable td, table.blueTable th {
                border: 1px solid #AAAAAA;
                padding: 3px 2px;
            }

            table.blueTable tbody td {
                font-size: 13px;
            }

            table.blueTable tr:nth-child(even) {
                background: #D0E4F5;
            }

            table.blueTable thead {
                background: #1C6EA4;
                background: -moz-linear-gradient(top, #5592bb 0%, #327cad 66%, #1C6EA4 100%);
                background: -webkit-linear-gradient(top, #5592bb 0%, #327cad 66%, #1C6EA4 100%);
                background: linear-gradient(to bottom, #5592bb 0%, #327cad 66%, #1C6EA4 100%);
                border-bottom: 2px solid #444444;
            }

                table.blueTable thead th {
                    font-size: 15px;
                    font-weight: bold;
                    color: #FFFFFF;
                    border-left: 2px solid #D0E4F5;
                }

                    table.blueTable thead th:first-child {
                        border-left: none;
                    }

            table.blueTable tfoot {
                font-size: 14px;
                font-weight: bold;
                color: #FFFFFF;
                background: #D0E4F5;
                background: -moz-linear-gradient(top, #dcebf7 0%, #d4e6f6 66%, #D0E4F5 100%);
                background: -webkit-linear-gradient(top, #dcebf7 0%, #d4e6f6 66%, #D0E4F5 100%);
                background: linear-gradient(to bottom, #dcebf7 0%, #d4e6f6 66%, #D0E4F5 100%);
                border-top: 2px solid #444444;
            }

                table.blueTable tfoot td {
                    font-size: 14px;
                }

                table.blueTable tfoot .links {
                    text-align: right;
                }

                    table.blueTable tfoot .links a {
                        display: inline-block;
                        background: #1C6EA4;
                        color: #FFFFFF;
                        padding: 2px 8px;
                        border-radius: 5px;
                    }

        .ag-floating-bottom-container {
            background: #1C6EA4 !important;
        }
    </style>

    <div class="row" id="divfilter">
        <div class="col-md-12">
            <div class="col-md-12">
                <div class="form-group">
                    <asp:Button ID="btnExport" Text="Export" runat="server" OnClick="ExportExcel_Click" CssClass="btn btn-primary" />
                    <div id="myGrid" class="table-responsive ag-theme-balham" style="height: 400px; width: 100%;">
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
    </div>

    <div class="modal" tabindex="-1" role="dialog" id="gridModal">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="ModalTitle" style="color: #FFFFFF;">Prodcut details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" style="height: 300px;">
                    <div id="modalBody" class="col-xs-12">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
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
        });


        function GetFileData(fileValue) {

            $.ajax({
                method: "POST",
                url: "MasterSKUList.aspx/GetFileData",
                contentType: "application/json; charset=utf-8",
                data: '{ fileName: "' + fileValue + '"}',
                success: function (data) {

                    if (data != null && data.d.length > 0) {

                        var fData = $.parseJSON(data.d);

                        BindGrid(JSON.stringify(fData.jsonData));
                        //debugger;
                        if (fData.ErrorList.length > 0) {
                            $('#parseError').show();
                            $('#parseError').html('<h2>Data Parse Error</h2><table class="blueTable"><thead><tr><th>GID</th><th>Column</th><th>Value</th><th>Description</th></tr></thead>' + fData.ErrorList + '</table>');
                        }
                        else {
                            $('#parseError').hide();
                        }
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
            { headerName: "GLAZERS PRODUCT CODE", field: "GlazersProductCode", cellStyle: { textAlign: 'center' }, sortable: true, filter: true },
            { headerName: "Category", field: "Category", cellStyle: { textAlign: 'center' }, sortable: true, filter: true, width: 130 },
            { headerName: "Sub Category", field: "SubCategory", cellStyle: { textAlign: 'center' }, sortable: true, filter: true, width: 130 },
            { headerName: "Supplier Name", field: "SupplierName", cellStyle: { textAlign: 'center' }, tooltipField: "SupplierName", sortable: true, filter: true, width: 130 },
            { headerName: "Brand Name", field: "BrandName", cellStyle: { textAlign: 'center' }, tooltipField: "BrandName", sortable: true, filter: true, width: 130 },
            { headerName: "Product Name", field: "ProductName", cellStyle: { textAlign: 'center' }, tooltipField: "ProductName", sortable: true, filter: true, width: 130 },
            { headerName: "Alternate Name", field: "AlternateName", cellStyle: { textAlign: 'center' }, tooltipField: "AlternateName", sortable: true, filter: true },
            { headerName: "Supplier Legal Names", field: "SupplierLegalName", cellStyle: { textAlign: 'center' }, tooltipField: "SupplierLegalName", sortable: true, filter: true },
            { headerName: "UPC/EAN-13", field: "UPC_EAN_13", cellStyle: { textAlign: 'center' }, sortable: true, filter: true },
            { headerName: "SCC-14", field: "SCC_14", cellStyle: { textAlign: 'center' }, sortable: true, filter: true },
            { headerName: "Supplier Internal Code", cellStyle: { textAlign: 'center' }, field: "Supplier_Internal_Code", sortable: true, filter: true },
            { headerName: "Supplier Internal Code 2", cellStyle: { textAlign: 'center' }, field: "Supplier_Internal_Code2", sortable: true, filter: true },
            { headerName: "Supplier Internal Code 3", cellStyle: { textAlign: 'center' }, field: "Supplier_Internal_Code3", sortable: true, filter: true },

            { headerName: "Category Code", cellStyle: { textAlign: 'center' }, field: "CategoryCode", width: 130 },
            { headerName: "Sub Category Code", cellStyle: { textAlign: 'center' }, field: "SubCategoryCode", width: 130 },
            { headerName: "Supplier Code", cellStyle: { textAlign: 'center' }, field: "SupplierCode", width: 130 },
            { headerName: "Brand Code", cellStyle: { textAlign: 'center' }, field: "BrandCode", width: 130 },
            { headerName: "Item Code", cellStyle: { textAlign: 'center' }, field: "ItemCode", width: 150 },


            { headerName: "ABV%", field: "ABV_Per", cellStyle: { textAlign: 'right' } },


            { headerName: "Container Type", field: "ContainerType", cellStyle: { textAlign: 'center' } },
            { headerName: "Container Volume (ml)", field: "ContainerVolume", cellStyle: { textAlign: 'right' } },
            { headerName: "Containers/Selling Unit", field: "Containers_Selling_Unit", cellStyle: { textAlign: 'right' } },
            { headerName: "Selling Units/Case", field: "Selling_Units_Case", cellStyle: { textAlign: 'right' } },


            { headerName: "BRITISH COLUMBIA", field: "ACD_British_Columbia", cellStyle: { textAlign: 'center' } },
            { headerName: "ALBERTA", field: "ACD_Alberta", cellStyle: { textAlign: 'center' } },
            { headerName: "SASKATCHEWAN", field: "ACD_Saskatchewan", cellStyle: { textAlign: 'center' } },
            { headerName: "MANITOBA", field: "ACD_Manitoba", cellStyle: { textAlign: 'center' } },
            { headerName: "ONTARIO", field: "ACD_Ontario", cellStyle: { textAlign: 'center' } },
            { headerName: "QUEBEC", field: "ACD_Quebec", cellStyle: { textAlign: 'center' } },
            { headerName: "NEWFOUNDLAND", field: "ACD_Newfoundland", cellStyle: { textAlign: 'center' } },
            { headerName: "NEW BRUNSWICK", field: "ACD_New_Brunswick", cellStyle: { textAlign: 'center' } },
            { headerName: "NOVA SCOTIA", field: "ACD_Nova_Scotia", cellStyle: { textAlign: 'center' } },
            { headerName: "PRINCE EDWARD ISLAND", field: "ACD_Prince_Edward_Island", cellStyle: { textAlign: 'center' } },
            { headerName: "NORTHWEST TERRITORIES", field: "ACD_Northwest_Territories", cellStyle: { textAlign: 'center' } },
            { headerName: "NUNAVUT", field: "ACD_Nunavut", cellStyle: { textAlign: 'center' } },
            { headerName: "YUKON", field: "ACD_Yukon", cellStyle: { textAlign: 'center' } },
            { headerName: "BRITISH COLUMBIA", field: "CSPC_British_Columbia", cellStyle: { textAlign: 'center' } },
            { headerName: "ALBERTA", field: "CSPC_Alberta", cellStyle: { textAlign: 'center' } },
            { headerName: "SASKATCHEWAN", field: "CSPC_Saskatchewan", cellStyle: { textAlign: 'center' } },
            { headerName: "MANITOBA", field: "CSPC_Manitoba", cellStyle: { textAlign: 'center' } },
            { headerName: "ONTARIO", field: "CSPC_Ontario", cellStyle: { textAlign: 'center' } },
            { headerName: "QUEBEC", field: "CSPC_Quebec", cellStyle: { textAlign: 'center' } },
            { headerName: "NEWFOUNDLAND", field: "CSPC_Newfoundland", cellStyle: { textAlign: 'center' } },
            { headerName: "NEW BRUNSWICK", field: "CSPC_New_Brunswick", cellStyle: { textAlign: 'center' } },
            { headerName: "NOVA SCOTIA", field: "CSPC_Nova_Scotia", cellStyle: { textAlign: 'center' } },
            { headerName: "PRINCE EDWARD ISLAND", field: "CSPC_Prince_Edward_Island", cellStyle: { textAlign: 'center' } },
            { headerName: "NORTHWEST TERRITORIES", field: "CSPC_Northwest_Territories", cellStyle: { textAlign: 'center' } },
            { headerName: "NUNAVUT", field: "CSPC_Nunavut", cellStyle: { textAlign: 'center' } },
            { headerName: "YUKON", field: "CSPC_Yukon", cellStyle: { textAlign: 'center' } },
            { headerName: "QUEBEC PRIVATE ORDER", field: "CSPC_Quebec_Private_Order", cellStyle: { textAlign: 'center' } },
            { headerName: "ONTARIO CONSIGNMENT", field: "CSPC_Ontario_Consignment", cellStyle: { textAlign: 'center' } },

            { headerName: "PM Owner", field: "PM_Owner", cellStyle: { textAlign: 'center' } },
            { headerName: "Closure Type", field: "Closure_Type", cellStyle: { textAlign: 'center' } },
            { headerName: "Closure Weight (grams)", field: "Closure_Weight", cellStyle: { textAlign: 'right' } },
            { headerName: "Bottle Weight (grams)", field: "Bottle_Weight", cellStyle: { textAlign: 'right' } },
            { headerName: "Bottle Height (cm)", field: "Bottle_Height", cellStyle: { textAlign: 'right' } },
            { headerName: "Bottle Length (cm)", field: "Bottle_Length", cellStyle: { textAlign: 'right' } },
            { headerName: "Bottle Width (cm)", field: "Bottle_Width", cellStyle: { textAlign: 'right' } },
            { headerName: "Empty Bottle Weight (grams)", field: "Empty_Bottle_Weight", cellStyle: { textAlign: 'right' } },
            { headerName: "Lead Time (Days)", field: "Lead_Time", cellStyle: { textAlign: 'right' } },
            { headerName: "Shipping Term", field: "Shipping_Term", cellStyle: { textAlign: 'center' } },
            { headerName: "Product Designation", field: "Product_Designation", cellStyle: { textAlign: 'center' } },
            { headerName: "Origin Country", field: "Origin_Country", cellStyle: { textAlign: 'center' } },
            { headerName: "Case Height (cm)", field: "Case_Height", cellStyle: { textAlign: 'right' } },
            { headerName: "Case Width (cm)", field: "Case_Width", cellStyle: { textAlign: 'right' } },
            { headerName: "Case Length (cm)", field: "Case_Length", cellStyle: { textAlign: 'right' } },
            { headerName: "Case Weight (kg)", field: "Case_Weight", cellStyle: { textAlign: 'right' } },
            { headerName: "Cases Per Pallet", field: "Cases_Per_Pallet", cellStyle: { textAlign: 'right' } },
            { headerName: "Layers Per Pallet", field: "Layers_Per_Pallet", cellStyle: { textAlign: 'right' } },
            { headerName: "Cases Per Layer", field: "Cases_Per_Layer", cellStyle: { textAlign: 'right' } },
            { headerName: "Cases / 20ft Container", field: "Cases_20ft_Container", cellStyle: { textAlign: 'right' } },
            { headerName: "Cases / 40ft Container", field: "Cases_40ft_Container", cellStyle: { textAlign: 'right' } },
            { headerName: "Cases / 40ft Heated Container", field: "Cases_40ft_Heated_Container", cellStyle: { textAlign: 'right' } },
            { headerName: "Appellation", field: "Appellation", cellStyle: { textAlign: 'center' } },
            { headerName: "Colour", field: "Colour", cellStyle: { textAlign: 'center' } },
            { headerName: "Residual Sugar", field: "Residual_Sugar", cellStyle: { textAlign: 'center' } },
            { headerName: "Grape Varietals (% each)", field: "Grape_Varietals", cellStyle: { textAlign: 'right' } },
            { headerName: "Variety (% of each) (Barley, Corn, Oats, Rye, Wheat)", field: "Variety", cellStyle: { textAlign: 'right' } },
            { headerName: "Aroma/Flavour", field: "Flavour", cellStyle: { textAlign: 'center' } },
            { headerName: "HQ Contact Name", field: "HQ_Contact_Name", cellStyle: { textAlign: 'center' } },
            { headerName: "HQ Contact Name Position", field: "HQ Contact Name Position", cellStyle: { textAlign: 'center' } },
            { headerName: "HQ Address", field: "HQ_Address", cellStyle: { textAlign: 'center' } },
            { headerName: "HQ City", field: "HQ_City", cellStyle: { textAlign: 'center' } },
            { headerName: "HQ Postal Code", field: "HQ_Postal_Code", cellStyle: { textAlign: 'center' } },
            { headerName: "HQ Country", field: "HQ_Country", cellStyle: { textAlign: 'center' } },
            { headerName: "HQ Phone Number", field: "HQ_Phone_Number", cellStyle: { textAlign: 'center' } },
            { headerName: "HQ Email", field: "HQ_Email", cellStyle: { textAlign: 'center' } }
        ];

        var eGridDiv = document.querySelector('#myGrid');
        var gridOptions;

        var gridOptions = {
            columnDefs: columnDefs,
            onRowDoubleClicked: ShowRowDetail,
            groupSelectsChildren: true,
            rowSelection: 'multiple',
            rowData: []
        };

        new agGrid.Grid(eGridDiv, gridOptions);

        function BindGrid(fileData) {
            gridOptions.api.setRowData(JSON.parse(fileData));
            $('#totalFooter').html('<b>Total: </b>' + gridOptions.api.getModel().getRowCount());
            $('#totalFooter').show();
        }

        function ShowRowDetail(row) {
            var strVal = "<tr><td><b>GID</b></td><td>" + row.data.GlazersProductCode + "</td></tr>";
            strVal = strVal + "<tr><td><b>Supplier</b></td><td>" + row.data.SupplierName + "</td></tr>";
            strVal = strVal + "<tr><td><b>Brand</b></td><td>" + row.data.BrandName + "</td></tr>";
            strVal = strVal + "<tr><td><b>Alternate Name</b></td><td>" + row.data.AlternateName + "</td></tr>";
            strVal = strVal + "<tr><td><b>Format</b></td><td>" + row.data.ContainerVolume + "x" + row.data.Containers_Selling_Unit + "x" + row.data.Selling_Units_Case + "</td></tr>";
            strVal = strVal + "<tr><td><b>ABV%</b></td><td>" + row.data.ABV_Per + "</td></tr>";
            strVal = strVal + "<tr><td><b>Category</b></td><td>" + row.data.Category + "</td></tr>";
            strVal = strVal + "<tr><td><b>Sub Category</b></td><td>" + row.data.SubCategory + "</td></tr>";

            strVal = '<table class="table table-condensed table-bordered table-striped">' + strVal + '</table>';

            $('#ModalTitle').text('Product Details');
            $('#modalBody').html(strVal);
            $('#gridModal').modal('toggle');
        }

        $(document).ready(function () {
            $('#divLoading').show();
            $.ajax({
                method: "POST",
                url: "MasterSKUList.aspx/GetProductData",
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

        });
    </script>

</asp:Content>

