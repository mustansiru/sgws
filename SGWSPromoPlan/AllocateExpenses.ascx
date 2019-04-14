<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AllocateExpenses.ascx.cs" Inherits="AllocateExpenses" %>

<%--<link href="stylesheets/jquery.tables.css" rel="stylesheet" />--%>
<script src="js/jquery.dataTables.min.js"></script>
<script src="js/CommonFunctions.js"></script>

<style>
    /*table {table-layout: fixed;}*/
    .modalAllocateExpenses .modal-header .close {
        margin-top: -22px;
    }
    .modalAllocateExpenses .modal-title {
        color: #fff;
    }
</style>
<!-- Modal -->
<div class="modal fade modalAllocateExpenses" id="modalAllocateExpenses" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document" style="width:80%">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="exampleModalLabel">Allocate Expenses</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">X</span>
                </button>
            </div>
            <div class="modal-body">

                <div class="row">
                    <div class="col-md-12 nopadding">
                       <%-- <div class="form-group">
                            <div id="divMessage" runat="server"></div>
                        </div>--%>
                        <div id="dvTotalExpensesSummary" class="form-group col-md-12 fontsize14" runat="server">
                                <label>Total Allocated Expenses: </label><label id="lblTotalAllocatedExpenses" class="TotalSummaryAmount"></label>
                                <label>Total Unallocated Expenses: </label><label id="lblTotalUnAllocatedExpenses" class="TotalSummaryAmount"></label>
                            </div>
                        <div class="clearfix"></div>
                        <div class="col-md-12">
                            <table id="tblProgram" cellspacing="0" border="0" rules="all" style="width: 100% !important;"
                                class="table table-bordered table-striped dataTable no-footer display select" role="grid">
                                <thead>
                                    <tr>
                                        <th class="grid-heading width10" rowspan="1" colspan="1">Program Name</th>
                                        <th class="grid-heading width8" rowspan="1" colspan="1">Province</th>
                                        <th class="grid-heading text-center width8" rowspan="1" colspan="1">SGWS Calendar Year</th>
                                        <th class="grid-heading text-center width8" rowspan="1" colspan="1">SGWS Calendar Period</th>
                                        <th class="grid-heading width8" rowspan="1" colspan="1">Liquor Board Period</th>
                                        <th class="grid-heading text-center width10" rowspan="1" colspan="1">Start Date</th>
                                        <th class="grid-heading text-center width10" rowspan="1" colspan="1">End Date</th>
                                        <th class="grid-heading text-center width7" rowspan="1" colspan="1">SGID</th>
                                        <th class="grid-heading text-center width15" rowspan="1" colspan="1">Product Description</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><label id="lblProgName"></label></td>
                                        <td class="text-center width8">
                                            <label id="lblProvince"></label></td>
                                        <td class="text-center width8">
                                            <label id="lblSGWSYear"></label></td>
                                        <td class="text-center width8">
                                            <label id="lblSGWSPeriod"></label></td>
                                        <td class="text-center width8">
                                            <label id="lblLiquorPeriod"></label></td>
                                        <td class="text-center">
                                            <label id="lblStartdate"></label></td>
                                        <td class="text-center">
                                            <label id="lblEnddate"></label></td>
                                        <td class="text-center">
                                            <label id="lblSGID"></label></td>
                                        <td>
                                            <label id="lblProductDesc"></label></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="clearfix"></div>
                        <div class="spacer20px"></div>
                        <div class="col-md-12">
                            <table id="tblAllocatedExpenses" cellspacing="0" border="0" rules="all" style="width: 100% !important;"
                                class="table table-bordered table-striped dataTable no-footer display select" role="grid">
                                <thead>
                                    <tr class="width100">
                                        <th class="grid-heading width8" rowspan="1" colspan="1">DeAllocate</th>
                                        <th class="grid-heading width8" rowspan="1" colspan="1">Record</th>
                                        <th class="grid-heading text-center width15" rowspan="1" colspan="1">Date</th>
                                        <th class="grid-heading text-center width8" rowspan="1" colspan="1">Province</th>
                                        <th class="grid-heading width10" rowspan="1" colspan="1">Program Type</th>
                                        <th class="grid-heading text-center width10" rowspan="1" colspan="1">Supplier</th>
                                        <th class="grid-heading text-center width12" rowspan="1" colspan="1">Brand</th>
                                        <th class="grid-heading text-center width10" rowspan="1" colspan="1">Employee</th>
                                        <th class="grid-heading text-center width10" rowspan="1" colspan="1">Total Amount Spent</th>
                                        <th class="grid-heading text-center width10" rowspan="1" colspan="1">Invoice #</th>
                                        <th class="grid-heading text-center width10" rowspan="1" colspan="1">Invoice Description</th>
                                    </tr>
                                </thead>
                                <tbody id="tbodyAllocatedExpenses"></tbody>
                            </table>
                        </div>

                        <div class="clearfix"></div>
                        <div class="spacer20px"></div>
                        <div class="col-md-12">
                            <table id="tblNotAllocatedExpenses" cellspacing="0" border="0" rules="all" style="width: 100% !important;"
                                class="table table-bordered table-striped dataTable no-footer display select" role="grid">
                                <thead>
                                    <tr>
                                        <th class="grid-heading width13" rowspan="1" colspan="1">Allocate</th>
                                        <th class="grid-heading width8" rowspan="1" colspan="1">Record</th>
                                        <th class="grid-heading text-center width10" rowspan="1" colspan="1">Date</th>
                                        <th class="grid-heading text-center width8" rowspan="1" colspan="1">Province</th>
                                        <th class="grid-heading  width10" rowspan="1" colspan="1">Program Type</th>
                                        <th class="grid-heading text-center width10" rowspan="1" colspan="1">Supplier</th>
                                        <th class="grid-heading text-center width12" rowspan="1" colspan="1">Brand</th>
                                        <th class="grid-heading text-center width10" rowspan="1" colspan="1">Employee</th>
                                        <th class="grid-heading text-center width10" rowspan="1" colspan="1">Total Amount Spent</th>
                                        <th class="grid-heading text-center width10" rowspan="1" colspan="1">Invoice #</th>
                                        <th class="grid-heading text-center width10" rowspan="1" colspan="1">Invoice Description</th>
                                    </tr>
                                </thead>
                                <tbody id="tbodyNotAllocatedExpenses"></tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    //$(function () {
        //jqueryDatatable_Expenses();
        //setTimeout(function () {
        //    $($.fn.dataTable.tables(true)).DataTable().columns.adjust().draw();
        //}, 200);
    //});

    function ShowAllocateexpensePopup(programId) {
        $("#modalAllocateExpenses").modal("show");
        GetAllExpenses(programId);
        //$("#tbodyAllocatedExpenses").html("");
        //$("#tbodyNotAllocatedExpenses").html("");
    }

    function GetAllExpenses(programId) {
        $.ajax({
                method: "GET",
                url: "<%= this.ResolveUrl("~/SGWS.asmx")%>/GetAllExpenses?ProgramId=" + programId,
                processData: false,                
                success: function (data) {
                    if (data != null) {
                        var ProgramDetails = JSON.parse(data.ProgramDetails);
                        if (ProgramDetails != null && ProgramDetails.length > 0) {
                            BindProgramDetails(ProgramDetails[0]);
                        }
                        var AllocateExpenses = JSON.parse(data.AllocateExpenses);
                        //if (AllocateExpenses != null && AllocateExpenses.length > 0) {
                            BindAllocatedExpenses(AllocateExpenses);
                       // }
                        var NotAllocateExpenses = JSON.parse(data.NotAllocateExpenses);
                        //if (NotAllocateExpenses != null && NotAllocateExpenses.length > 0) {
                            BindNotAllocatedExpenses(NotAllocateExpenses);
                        //}
                            TotalAllocatedDeallocatedAmount(data);
                        //var AllocatedTotalAmount = JSON.parse(data.AllocatedTotalAmount);
                        //if (AllocatedTotalAmount != null && AllocatedTotalAmount.length > 0) {
                        //    $("#lblTotalAllocatedExpenses").text(numberWithCommas(AllocatedTotalAmount[0].AllocatedTotalAmount));
                        //}
                        //var NotAllocatedTotalAmount = JSON.parse(data.NotAllocatedTotalAmount);
                        //if (NotAllocatedTotalAmount != null && NotAllocatedTotalAmount.length > 0) {
                        //    $("#lblTotalUnAllocatedExpenses").text(numberWithCommas(NotAllocatedTotalAmount[0].NotAllocatedTotalAmount));
                        //}
                        jqueryDatatable_Expenses();
                    }
                }
            });
    }
    function AllocateExpenses(ExpenseId, ProgramId) {
        $.ajax({
            method: "GET",
            url: "<%= this.ResolveUrl("~/SGWS.asmx")%>/AllocateExpenses?ExpenseId="+ExpenseId+"&ProgramId="+ ProgramId,
            processData: false,
            success: function (data) {
                if (data != null) {
                    var deletedRow=$("#tblNotAllocatedExpenses tbody tr#rptNotAllocateExpenses_tr"+ExpenseId);                        
                    $(deletedRow).find("td:first").find("input[type='checkbox']").prop("checked",true);                        
                    $(deletedRow).find("td:first").find("input[type='checkbox']").removeAttr("onchange");
                    $(deletedRow).remove();
                    //$("#tblNotAllocatedExpenses tbody tr#rptNotAllocateExpenses_tr"+ExpenseId+" input [type='checkbox']").prop("checked",true);
                    $("#tblAllocatedExpenses tbody tr:first td.dataTables_empty").parent('tr').remove();
                    $("#tblAllocatedExpenses tbody").append(deletedRow);
                    $(deletedRow).find("td:first").find("input[type='checkbox']").attr("onchange", "return DeAllocateExpenses(" + ExpenseId + "," + ProgramId + ");");
                    $(deletedRow).attr("id", "rptAllocateExpenses_tr" + ExpenseId);

                    TotalAllocatedDeallocatedAmount(data);
                    //jqueryDatatable_Expenses();

                }
            }
        });
    }
    function DeAllocateExpenses(ExpenseId, ProgramId) {
            
        $.ajax({
            method: "GET",
            url: "<%= this.ResolveUrl("~/SGWS.asmx")%>/DeAllocateExpense?ExpenseId="+ExpenseId+"&ProgramId="+ ProgramId,
            processData: false,
            success: function (data) {
                if (data != null) {
                    var deletedRow=$("#tblAllocatedExpenses tbody tr#rptAllocateExpenses_tr"+ExpenseId);
                    $(deletedRow).find("td:first").find("input[type='checkbox']").prop("checked",false);
                    $(deletedRow).find("td:first").find("input[type='checkbox']").removeAttr("onchange");
                    $(deletedRow).remove();
                    //$("#tblAllocatedExpenses tbody tr#rptAllocateExpenses_tr"+ExpenseId + " input [type='checkbox']").prop("checked",false);
                    $("#tblNotAllocatedExpenses tbody tr:first td.dataTables_empty").parent('tr').remove();
                    $("#tblNotAllocatedExpenses tbody").append(deletedRow);
                    $(deletedRow).find("td:first").find("input[type='checkbox']").attr("onchange", "return AllocateExpenses(" + ExpenseId + "," + ProgramId + ");");
                    $(deletedRow).attr("id", "rptNotAllocateExpenses_tr" + ExpenseId);

                    TotalAllocatedDeallocatedAmount(data);
                    //jqueryDatatable_Expenses();
                }
            }
        });
    }

    function TotalAllocatedDeallocatedAmount(data) {
        var AllocatedTotalAmount = JSON.parse(data.AllocatedTotalAmount);
        if (AllocatedTotalAmount != null && AllocatedTotalAmount.length > 0) {
            $("#lblTotalAllocatedExpenses").text(numberWithCommas(AllocatedTotalAmount[0].AllocatedTotalAmount));
        }
        var NotAllocatedTotalAmount = JSON.parse(data.NotAllocatedTotalAmount);
        if (NotAllocatedTotalAmount != null && NotAllocatedTotalAmount.length > 0) {
            $("#lblTotalUnAllocatedExpenses").text(numberWithCommas(NotAllocatedTotalAmount[0].NotAllocatedTotalAmount));
        }
    }
    function BindProgramDetails(ProgramDetails) {
        $("#lblProgName").text(ProgramDetails.ProgramTypeName);
        $("#lblProvince").text(ProgramDetails.Code);
        $("#lblSGWSYear").text(ProgramDetails.Year);
        $("#lblSGWSPeriod").text(ProgramDetails.Period);
        $("#lblLiquorPeriod").text(ProgramDetails.LiquorBoardPeriod);
        $("#lblStartdate").text(ProgramDetails.StartDate);
        $("#lblEnddate").text(ProgramDetails.EndDate);
        $("#lblSGID").text(ProgramDetails.GID);
        $("#lblProductDesc").text(ProgramDetails.AlternateName);
    }

    function BindAllocatedExpenses(AllocateExpenses) {
        var rows = "";
        $.each(AllocateExpenses, function (i, item) {
            rows += '<tr id="rptAllocateExpenses_tr' + item.ExpenseId + '">' +
                    '<td class="text-center width8"><input type="checkbox" checked="checked" onchange="return DeAllocateExpenses(' + item.ExpenseId + ',' + item.ProgramId + ');" /></td>' +
                    '<td class="text-center width8">' + item.Record + '</td>' +
                    '<td class="text-center" style="width:13.5% !important;">' + item.Date + '</td> ' +
                    '<td class="text-center width8">' + item.Code + '</td>  ' +
                    '<td class="width10">' + item.Employee + '</td>         ' +
                    '<td class="width10">' + item.ProgramType + '</td>      ' +
                    '<td class="width10">' + item.SupplierName + '</td>     ' +
                    '<td class="width10">' + item.BrandName + '</td>        ' +
                    '<td class="text-center width8">' + item.Total + '</td>' +
                    '<td class="text-center width10">' + item.InvoiceNo + '</td>' +
                    '<td class="width10">' + item.InvoiceDescription + '</td>   ' +
                    '</tr>';
        });

        $("#tbodyAllocatedExpenses").html("");
        if (rows == "") {
            rows = "<tr class='odd'><td colspan='11' class='dataTables_empty' style='font-size: 13px;'>No data available in table</td></tr>";
        }
        $("#tbodyAllocatedExpenses").append(rows);
    }

    function BindNotAllocatedExpenses(NotAllocateExpenses) {
        var rows = "";
        $.each(NotAllocateExpenses, function (i, item) {
            rows += '<tr id="rptNotAllocateExpenses_tr' + item.ExpenseId + '">'+
                    '<td class="text-center width13"><input type="checkbox" onchange="return AllocateExpenses(' + item.ExpenseId + ',' + item.ProgramId + ');" /></td>' +
                    '<td class="text-center width8">' + item.Record + '</td>' +
                    '<td class="text-center width12">' + item.Date + '</td> ' +
                    '<td class="text-center width8">' + item.Code + '</td>  ' +
                    '<td class="width10">' + item.ProgramType + '</td>      ' +
                    '<td class="width10">' + item.SupplierName + '</td>     ' +
                    '<td class="width10">' + item.BrandName + '</td>        ' +
                    '<td class="width10">' + item.Employee + '</td>         ' +
                    '<td class="text-center width8">' + item.Total + '</td>' +
                    '<td class="text-center width10">' + item.InvoiceNo + '</td>' +
                    '<td class="width10">' + item.InvoiceDescription + '</td>   ' +
                    '</tr>';
        });

        $("#tbodyNotAllocatedExpenses").html("");
        if (rows == "") {
            rows = "<tr class='odd'><td colspan='11' class='dataTables_empty' style='font-size: 13px;'>No data available in table</td></tr>";
        }
        $("#tbodyNotAllocatedExpenses").append(rows);
        //'<tr id="rptNotAllocateExpenses_tr'+ item.ExpenseId+ '">
        //                                        <td class="text-center width8">
        //                                            <input type="checkbox" onchange="return AllocateExpenses('+ item.ExpenseId+ ');" /></td>
        //                                        <td class="text-center width8">'+ item.Record+ '</td>
        //                                        <td class="text-center width10">'+ item.Date+ '</td>
        //                                        <td class="text-center width8">'+ item.Code+ '</td>
        //                                        <td class=" width10">'+ item.ProgramType+ '</td>
        //                                        <td class=" width10">'+ item.SupplierName+ '</td>
        //                                        <td class=" width10">'+ item.BrandName+ '</td>
        //                                        <td class=" width10">'+ item.Employee+ '</td>
        //                                        <td class="text-center width10">'+ item.InvoiceNo+ '</td>
        //                                        <td class=" width10">'+ item.InvoiceDescription+ '</td>
        //                                    </tr>'
    }
    function jqueryDatatable_Expenses() {
        $('#tblProgram').dataTable({
            "bDestroy": true,
            bFilter: false,
            "scrollX": true,
            bSort: false,
            bLengthChange: false,
            paging: false,
            bInfo: false
        });

        $('#tblAllocatedExpenses').dataTable({
            // iDisplayLength: 100,
            "bDestroy": true,
            bFilter: false,
            "scrollY": 300,
            "scrollX": true,
            "order": [[1, 'asc']],
            bSort: true,
            bLengthChange: false,
            paging: false,
            bInfo: false,
            aoColumnDefs: [
                      {
                          bSortable: false,
                          aTargets: [0]
                      }
            ]
        });

        $('#tblNotAllocatedExpenses').dataTable({
            // iDisplayLength: 100,
            "bDestroy": true,
            bFilter: true,
            "scrollY":300,
            "scrollX": true,
            "order": [[1, 'asc']],
            bSort: true,
            bLengthChange: false,
            paging: false,
            bInfo: false,
            aoColumnDefs: [
                      {
                          bSortable: false,
                          aTargets: [0]
                      }
            ]
        });
    }
</script>
