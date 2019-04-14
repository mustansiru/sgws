<%@ Page Title="Manage Program" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ManageProgram.aspx.cs" 
    Inherits="ManageProgram" EnableEventValidation="false" %>

<%@ Register Src="~/AddEditProgram.ascx" TagName="UserInformation" TagPrefix="ucAddEditProgram" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" rel="stylesheet" />
    
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
    <%--<script type="text/javascript" src="js/program.js"></script>--%>
    <style>
        table.blueTable {
            /*border: 1px solid #1C6EA4;*/
            background-color: #EEEEEE;
            width: 100%;
            text-align: left;
            border-collapse: collapse;
        }

            table.blueTable td, table.blueTable th {
                padding: 3px 2px;
                text-align: center;
            }

            table.blueTable tbody td {
                font-size: 13px;
            }

            table.blueTable tr:nth-child(even) {
                background: #EEEEEE;
            }

            table.blueTable thead {
                background: #1C6EA4;
                background: -moz-linear-gradient(top, #5592bb 0%, #327cad 66%, #1C6EA4 100%);
                background: -webkit-linear-gradient(top, #5592bb 0%, #327cad 66%, #1C6EA4 100%);
                background: linear-gradient(to bottom, #5592bb 0%, #327cad 66%, #1C6EA4 100%);
                /*border-bottom: 1px solid #444444;*/
            }

                table.blueTable thead th {
                    background: #c1b7b7;
                    font-size: 15px;
                    font-weight: bold;
                    color: #FFFFFF;
                    border-left: 0px solid #D0E4F5;
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
                border-top: 0px solid #444444;
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
                        /*border-radius: 1px;*/
                    }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <cc1:ToolkitScriptManager CombineScripts="True" runat="server" EnablePartialRendering="true"></cc1:ToolkitScriptManager>
    <div class="row" id="divfilter">
        <div class="col-md-12">
            <div class="col-md-12">
                <div class="form-group">
                    <div id="divMessage" runat="server">
                    </div>
                    <div class="padding-bottom pull-left">
                        <br />
                        <asp:HyperLink ID="hlProgramList" CssClass="btn btn-primary" runat="server">
                        Program List
                        </asp:HyperLink>
                    </div>
                    <div class="padding-bottom pull-right">
                        <br />
                        <button type="button" class="btn btn-primary" id="btnAddProgram" ><%-- data-toggle="modal" data-target="#exampleModal"--%>
                            Add Program Wizard
                        </button>
                        <%-- <asp:HyperLink ID="hlAdd" CssClass="btn btn-primary" runat="server">
                        <i class="fa fa-plus" aria-hidden="true">&nbsp;&nbsp;</i>Add Program
                        </asp:HyperLink>--%>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
            <div class="col-md-12">
                <div class="table-responsive" id="divprogramlistingtablecontainer">
                    <table id="tblProgramLsting" class="table responsive table-striped table-bordered nowrap" style="width: 100%">
                        <thead>
                            <tr role="row">
                                <th></th>
                                <th>Id</th>
                                <th class="grid-heading">Actions</th>
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

                            </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <ucAddEditProgram:UserInformation runat="server" ID="ucAddEditProgram" PopupOpener="btnAddProgram" />

    <%--<script src="../lib/bootstrap/js/bootstrap4.min.js"></script>--%>
    

    <script>
        var tblProgramData;
        // Array to track the ids of the details displayed rows
        var detailRows = [];

        $(document).ready(function () {
            JqueryDatatable();

            // Array to track the ids of the details displayed rows

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

                    //var detailTable = $(this).closest('table');
                    //debugger;
                    //$(detailTable).addClass('blueTable');
                    // Add to the 'open' array
                    if (idx === -1) {
                        detailRows.push(tr.attr('id'));
                    }
                }

            });

            // On each draw, loop over the `detailRows` array and show any child rows
            //tblProgramData.on('draw', function () {
            //    $.each(detailRows, function (i, id) {
            //        $('#' + id + ' td.details-control').trigger('click');
            //    });
            //});
        });


        function JqueryDatatable() {

            tblProgramData = $('#tblProgramLsting').dataTable({
                "ajax":
                {
                    "url": "ManageProgram.aspx/LoadData",
                    "contentType": "application/json",
                    "type": "GET",
                    "dataType": "JSON",
                    //async: false,
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
                "bAutoWidth": false,
                "processing": true,
                "serverSide": true,
                "responsive": true,
                //fixedHeader: true,
                columns: [
                    {
                        "className": 'details-control',
                        "orderable": false,
                        "data": null,
                        "defaultContent": '', "sWidth": "50px",
                        "bSortable": false
                    },
                    { 'data': 'SuperProgramId', "sWidth": "20px", "visible": false },
                    {
                        "bSortable": false,
                        'class': 'text-center',
                        "render": function (data, type, full, meta) {
                            if (full.IsAccess) {
                                //return '<a href="program.aspx?SuperProgramId=' + full.SuperProgramId + '" title="Edit Program"><i class="fa fa-pencil" ></i></a>' +
                                //    ' | <a href=\"javascript:void(0);\" title="Copy Program" onclick=\"return CopySuperProgram(' + full.SuperProgramId + ')\"><i class=\"fa fa-files-o\"></i></a>';
                                return '<a href=\"javascript:void(0);\" onclick="GetProgramDetailsBySuperProgramId(' + full.SuperProgramId + ');" title="Edit Program"><i class="fa fa-pencil" ></i></a>' +
                                    ' | <a href=\"javascript:void(0);\" title="Copy Program" onclick=\"return CopySuperProgram(' + full.SuperProgramId + ')\"><i class=\"fa fa-files-o\"></i></a>';
                            } else {
                                return '<a href=\"javascript:void(0);\" title="Copy Program" onclick=\"return CopySuperProgram(' + full.SuperProgramId + ')\"><i class=\"fa fa-files-o\"></i></a>';
                            }
                        }
                    },
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
                    { 'data': 'AlternateName', "sWidth": "200px", "className": "text-center" }
                ],
                scrollX: true,
                //scrollY: "700px",
                //scrollCollapse: true,
                bInfo: false,
                paging: true,
                bLengthChange: false,
                "bDestroy": true
                //fixedColumns: {
                //    leftColumns: 3,
                //}
            });


            //new $.fn.dataTable.FixedHeader(tblProgramData);
        }

        function format(d) {
            var detailData = "";
            //$('#divLoading').show();
            $.ajax({
                method: "GET",
                url: "ManageProgram.aspx/LoadDetailData",
                contentType: "application/json; charset=utf-8",
                data: { superProgramId: d.SuperProgramId },
                async: false,
                success: function (data) {
                    detailData = data.d;
                    //$('#divLoading').hide();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //$('#divLoading').hide();
                }
            });

            return detailData;
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

        //function refresh_datatable() {
        //    tblProgramData.ajax.reload();
        //}              
       
</script>
</asp:Content>

