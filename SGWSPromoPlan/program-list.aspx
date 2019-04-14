<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="program-list.aspx.cs" Inherits="program_list" %>
<%@ Register Src="~/AddEditProgram.ascx" TagName="UserInformation" TagPrefix="ucAddEditProgram" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" rel="stylesheet" />
    <%--<link href="https://cdn.datatables.net/select/1.2.7/css/select.dataTables.min.css" rel="stylesheet" />--%>
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
    <%--<script type="text/javascript" src="https://cdn.datatables.net/select/1.2.7/js/dataTables.select.min.js"></script>--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row" id="divfilter">
        <div class="col-md-12">
            <div class="col-md-12">
                <div class="form-group">
                    <div id="divMessage" runat="server">
                    </div>
                    <div class="padding-bottom pull-left">
                        <br />
                        <asp:HyperLink ID="hlManageProgram" CssClass="btn btn-primary" runat="server">
                        Manage Program
                        </asp:HyperLink>
                    </div>

                    <div class="padding-bottom pull-right">
                        <br />
                        <%--<asp:HyperLink ID="hlAdd" CssClass="btn btn-primary" runat="server">
                        <i class="fa fa-plus" aria-hidden="true">&nbsp;&nbsp;</i>Add Program
                        </asp:HyperLink>--%>
                         <button type="button" class="btn btn-primary" id="btnAddProgram">
                            Add Program
                        </button>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
            <div class="col-md-12">
                <div class="table-responsive" id="divprogramlistingtablecontainer">
                    <table id="tblProgramLsting" class="table responsive table-striped table-bordered nowrap" style="width: 100%">
                        <thead>
                            <tr role="row">
                                <th>Id</th>
                                <th class="grid-heading">Program Name</th>
                                <th class="grid-heading">Province</th>
                                <th class="grid-heading">SGWS Calendar Year</th>
                                <th class="grid-heading">SGWS Calendar Period</th>
                                <th class="grid-heading">Liquor board Period</th>
                                <th class="grid-heading">Start Date</th>
                                <th class="grid-heading">End Date</th>
                                <th class="grid-heading">SKU/Brand</th>
                                <th class="grid-heading">Product Id (GID)</th>
                                <th class="grid-heading">Alternate Product Name</th>
                                <th class="grid-heading">Program Type Name</th>
                                <th class="grid-heading">Program Type</th>
                                <th class="grid-heading">ATL/BTL</th>
                                <th class="grid-heading">Comments</th>
                                <th class="grid-heading">Status</th>
                                <th class="grid-heading">Total Program Spend</th>
                            </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <div class="modal" tabindex="-1" role="dialog" id="gridModal">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="ModalTitle" style="color: #FFFFFF;">Update Program</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" style="height: 200px;">
                    <div id="modalBody" class="col-xs-12">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label>Super Program<span class="errorMessage">*</span></label>
                                <input type="text" id="txtSuperProgram" />
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label>Province <span class="errorMessage">*</span></label>
                                <input type="text" id="txtProvince" />
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label>SGWS Year <span class="errorMessage">*</span></label>
                                <input type="text" id="txtSGWSYear" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <ucAddEditProgram:UserInformation runat="server" ID="ucAddEditProgram" PopupOpener="btnAddProgram" />

    <script>
        var tblProgramData;

        $(document).ready(function () {
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

                    row.child(format(row.data())).show();

                    // Add to the 'open' array
                    if (idx === -1) {
                        detailRows.push(tr.attr('id'));
                    }
                }

            });

            //$('#tblProgramLsting tbody').on('dblclick', 'tr', function () {


            //    var tableData = $("#tblProgramLsting").DataTable().rows($(this).closest("tr")).data()[0];

            //    $('#txtSuperProgram').val($.trim(tableData.SuperProgramName));
            //    $('#txtProvince').val($.trim(tableData[2]));
            //    $('#txtSGWSYear').val($.trim(tableData[3]));
            //    $('#gridModal').modal('toggle');

            //    //debugger;
            //    //alert("Your data is: " + $.trim(tableData[0]) + " , " + $.trim(tableData[1]) + " , " + $.trim(tableData[2]) + " , " + $.trim(tableData[3]) + " , " + $.trim(tableData[4]));

            //});
        });


        function JqueryDatatable() {

            tblProgramData = $('#tblProgramLsting').dataTable({
                "ajax":
                {
                    "url": "program-list.aspx/LoadData",
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
                select: {
                    style: 'single'
                },
                "bAutoWidth": false,
                "processing": true,
                "serverSide": true,
                "responsive": true,
                columns: [
                    { 'data': 'SuperProgramId', "sWidth": "20px", "visible": false },
                    { 'data': 'SuperProgramName', "sWidth": "130px", "className": "text-center" },
                    { 'data': 'ProvinceCode', "sWidth": "60px", "className": "text-center" },
                    { 'data': 'SGWS_Calendar_Year', "sWidth": "200px", "className": "text-center" },
                    { 'data': 'SGWS_Calendar_Period', "sWidth": "200px", "className": "text-center" },
                    { 'data': 'LiquorBoardPeriod', "sWidth": "200px", "className": "text-center" },
                    {
                        'data': 'StartDate',
                        "sWidth": "100px",
                        "className": "text-center",
                        "render": function (data, type, full, meta) {
                            if (full.StartDate != null) {
                                var StartDate = eval(full.StartDate.replace(/\/Date\((\d+)\)\//gi, "new Date($1)"));
                                var month = ("0" + (StartDate.getMonth() + 1)).slice(-2);
                                var day = ("0" + StartDate.getDate()).slice(-2);
                                var year = StartDate.getFullYear();
                                var myDate = year + '' + month + '' + day;
                                return myDate;
                            }
                            else
                                return '';
                        }
                    },
                    {
                        'data': 'EndDate',
                        "sWidth": "100px",
                        "className": "text-center",
                        "render": function (data, type, full, meta) {
                            if (full.EndDate != null) {
                                var endDate = eval(full.EndDate.replace(/\/Date\((\d+)\)\//gi, "new Date($1)"));
                                var month = ("0" + (endDate.getMonth() + 1)).slice(-2);
                                var day = ("0" + endDate.getDate()).slice(-2);
                                var year = endDate.getFullYear();
                                var myDate = year + '' + month + '' + day;
                                return myDate;
                            }
                            else
                                return '';
                        }
                    },
                    {
                        'data': 'IsSkuBased', "sWidth": "100px",
                        "className": "text-center",
                        "render": function (data, type, full, meta) {

                            if (full.IsSkuBased == true) {
                                return 'SKU';
                            }
                            else {
                                return 'Brand';
                            }
                        }
                    },
                    { 'data': 'GID', "sWidth": "100px", "className": "text-center" },
                    { 'data': 'AlternateName', "sWidth": "200px", "className": "text-center" },
                    { 'data': 'ProgramTypeName', "sWidth": "200px", "className": "text-center" },
                    { 'data': 'ProgramType', "sWidth": "200px", "className": "text-center" },
                    { 'data': 'AboveTheLineBelowTheLineName', "sWidth": "200px", "className": "text-center" },
                    { 'data': 'Comment', "sWidth": "200px", "className": "text-center" },
                    { 'data': 'ProgramStatusCode', "sWidth": "200px", "className": "text-center" },
                    {
                        'data': 'TotalProgramSpend', "sWidth": "200px",
                        "className": "text-right",
                        "render": function (data, type, full, meta) {
                            if (full.TotalProgramSpend != null)
                                return '$' + full.TotalProgramSpend;
                            else
                                return '';
                        }
                    }
                ],
                bInfo: false,
                paging: true,
                "bDestroy": true
            });

        }
    </script>
</asp:Content>

