<%@ Page Title="Allocate Expenses" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AllocateExpenses.aspx.cs" Inherits="AllocateExpenses" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="stylesheets/jquery.tables.css" rel="stylesheet" />
    <script src="js/jquery.dataTables.min.js"></script>

    <style>
        table {table-layout:fixed;}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
                <div id="divMessage" runat="server">
                </div>
            </div>
            <div class="clearfix"></div>
            <div class="col-md-12">
                <div class="text-right">
                    <a class="btn btn-default btnback" href="RegionalView.aspx">BACK</a>
                </div>
            </div>
            <div class="clearfix"></div>
            <div class="spacer20px"></div>
            <div class="col-md-12">
                <table id="tblProgram" cellspacing="0" border="0" rules="all" style="width:100% !important;" 
                    class="table table-bordered table-striped dataTable no-footer display select" role="grid">
                    <thead>
                         <tr>
                            <th class="grid-heading" rowspan="1" colspan="1">Program Name</th>
                            <th class="grid-heading width8" rowspan="1" colspan="1">Province</th>
                            <th class="grid-heading text-center width8" rowspan="1" colspan="1">SGWS Calendar Year</th>
                            <th class="grid-heading text-center width8" rowspan="1" colspan="1">SGWS Calendar Period</th>
                            <th class="grid-heading width8" rowspan="1" colspan="1">Liquor Board Period</th>
                            <th class="grid-heading text-center width10" rowspan="1" colspan="1">Start Date</th>
                            <th class="grid-heading text-center width10" rowspan="1" colspan="1">End Date</th>
                            <th class="grid-heading text-center width7" rowspan="1" colspan="1">SGID</th>
                            <th class="grid-heading text-center" rowspan="1" colspan="1">Product Description</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><asp:Label ID="lblProgName" runat="server"></asp:Label></td>
                            <td class="text-center width8"><asp:Label ID="lblProvince" runat="server"></asp:Label></td>
                            <td class="text-center width8"><asp:Label ID="lblSGWSYear" runat="server"></asp:Label></td>
                            <td class="text-center width8"><asp:Label ID="lblSGWSPeriod" runat="server"></asp:Label></td>
                            <td class="text-center width8"><asp:Label ID="lblLiquorPeriod" runat="server"></asp:Label></td>
                            <td class="text-center"><asp:Label ID="lblStartdate" runat="server"></asp:Label></td>
                            <td class="text-center"><asp:Label ID="lblEnddate" runat="server"></asp:Label></td>
                            <td class="text-center"><asp:Label ID="lblSGID" runat="server"></asp:Label></td>
                            <td><asp:Label ID="lblProductDesc" runat="server"></asp:Label></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="clearfix"></div>
            <div class="spacer20px"></div>
            <div class="col-md-12">
                <table id="tblAllocatedExpenses" cellspacing="0" border="0" rules="all" style="width:100% !important;" 
                    class="table table-bordered table-striped dataTable no-footer display select" role="grid">
                    <thead>
                         <tr>
                            <th class="grid-heading width8" rowspan="1" colspan="1">DeAllocate</th>
                            <th class="grid-heading width8" rowspan="1" colspan="1">Record</th>
                            <th class="grid-heading text-center width10" rowspan="1" colspan="1">Date</th>
                            <th class="grid-heading text-center width8" rowspan="1" colspan="1">Province</th>
                            <th class="grid-heading width10" rowspan="1" colspan="1">Program Type</th>
                            <th class="grid-heading text-center width10" rowspan="1" colspan="1">Supplier</th>
                            <th class="grid-heading text-center width10" rowspan="1" colspan="1">Brand</th>
                            <th class="grid-heading text-center width10" rowspan="1" colspan="1">Employee</th>
                            <th class="grid-heading text-center width10" rowspan="1" colspan="1">Invoice #</th>
                            <th class="grid-heading text-center width10" rowspan="1" colspan="1">Invoice Description</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptAllocateExpenses" runat="server">
                            <ItemTemplate>
                                <tr id="rptAllocateExpenses_tr<%# Eval("ExpenseId") %>">
                                    <td class="text-center width8"><input type="checkbox" checked="checked" onchange="return DeAllocateExpenses(<%# Eval("ExpenseId") %>);" /></td>
                                    <td class="text-center width8"><%# Eval("Record") %></td>
                                    <td class="text-center width10"><%# Eval("Date") %></td>
                                    <td class="text-center width8"><%# Eval("Code") %></td>
                                    <td class="width10"><%# Eval("Employee") %></td>
                                    <td class="width10"><%# Eval("ProgramType") %></td>
                                    <td class="width10"><%# Eval("SupplierName") %></td>
                                    <td class="width10"><%# Eval("BrandName") %></td>
                                    <td class="text-center width10"><%# Eval("InvoiceNo") %></td>
                                    <td class="width10"><%# Eval("InvoiceDescription") %></td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>

            <div class="clearfix"></div>
            <div class="spacer20px"></div>
            <div class="col-md-12">
                <table id="tblNotAllocatedExpenses" cellspacing="0" border="0" rules="all" style="width:100% !important;" 
                    class="table table-bordered table-striped dataTable no-footer display select" role="grid">
                    <thead>
                         <tr>
                            <th class="grid-heading width8" rowspan="1" colspan="1">Allocate</th>
                            <th class="grid-heading width8" rowspan="1" colspan="1">Record</th>
                            <th class="grid-heading text-center width10" rowspan="1" colspan="1">Date</th>
                            <th class="grid-heading text-center width8" rowspan="1" colspan="1">Province</th>
                            <th class="grid-heading  width10" rowspan="1" colspan="1">Program Type</th>
                            <th class="grid-heading text-center width10" rowspan="1" colspan="1">Supplier</th>
                            <th class="grid-heading text-center width10" rowspan="1" colspan="1">Brand</th>
                            <th class="grid-heading text-center width10" rowspan="1" colspan="1">Employee</th>
                            <th class="grid-heading text-center width10" rowspan="1" colspan="1">Invoice #</th>
                            <th class="grid-heading text-center width10" rowspan="1" colspan="1">Invoice Description</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptNotAllocateExpenses" runat="server">
                            <ItemTemplate>
                                <tr id="rptNotAllocateExpenses_tr<%# Eval("ExpenseId") %>">
                                    <td class="text-center width8"><input type="checkbox" onchange="return AllocateExpenses(<%# Eval("ExpenseId") %>);" /></td>
                                    <td class="text-center width8"><%# Eval("Record") %></td>
                                    <td class="text-center width10"><%# Eval("Date") %></td>
                                    <td class="text-center width8"><%# Eval("Code") %></td>
                                    <td class=" width10"><%# Eval("ProgramType") %></td>
                                    <td class=" width10"><%# Eval("SupplierName") %></td>
                                    <td class=" width10"><%# Eval("BrandName") %></td>
                                    <td class=" width10"><%# Eval("Employee") %></td>
                                    <td class="text-center width10"><%# Eval("InvoiceNo") %></td>
                                    <td class=" width10"><%# Eval("InvoiceDescription") %></td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script>

        function AllocateExpenses(ExpenseId) {
            $.ajax({
                method: "GET",
                url: "<%= this.ResolveUrl("~/SGWS.asmx")%>/AllocateExpenses?ExpenseId="+ExpenseId+"&ProgramId="+ <%= ProgramId%>,
                processData: false,
                success: function (data) {
                    if (data != null && data>0) {
                        var deletedRow=$("#tblNotAllocatedExpenses tbody tr#rptNotAllocateExpenses_tr"+ExpenseId);                        
                        $(deletedRow).find("td:first").find("input[type='checkbox']").prop("checked",true);                        
                        $(deletedRow).find("td:first").find("input[type='checkbox']").removeAttr("onchange");
                        $(deletedRow).remove();
                        //$("#tblNotAllocatedExpenses tbody tr#rptNotAllocateExpenses_tr"+ExpenseId+" input [type='checkbox']").prop("checked",true);
                        $("#tblAllocatedExpenses tbody tr:first td.dataTables_empty").parent('tr').remove();
                        $("#tblAllocatedExpenses tbody").append(deletedRow);
                        $(deletedRow).find("td:first").find("input[type='checkbox']").attr("onchange","return DeAllocateExpenses("+ExpenseId+");");
                        $(deletedRow).attr("id","rptAllocateExpenses_tr"+ExpenseId);
                        //jqueryDatatable();
                    }
                }
            });
        }
        function DeAllocateExpenses(ExpenseId) {
            
            $.ajax({
                method: "GET",
                url: "<%= this.ResolveUrl("~/SGWS.asmx")%>/DeAllocateExpense?ExpenseId="+ExpenseId+"&ProgramId="+ <%= ProgramId%>,
                processData: false,
                success: function (data) {
                    if (data != null && data>0) {
                        var deletedRow=$("#tblAllocatedExpenses tbody tr#rptAllocateExpenses_tr"+ExpenseId);
                        $(deletedRow).find("td:first").find("input[type='checkbox']").prop("checked",false);
                        $(deletedRow).find("td:first").find("input[type='checkbox']").removeAttr("onchange");
                        $(deletedRow).remove();
                        //$("#tblAllocatedExpenses tbody tr#rptAllocateExpenses_tr"+ExpenseId + " input [type='checkbox']").prop("checked",false);
                        $("#tblNotAllocatedExpenses tbody tr:first td.dataTables_empty").parent('tr').remove();
                        $("#tblNotAllocatedExpenses tbody").append(deletedRow);
                        $(deletedRow).find("td:first").find("input[type='checkbox']").attr("onchange","return AllocateExpenses("+ExpenseId+");");
                        $(deletedRow).attr("id","rptNotAllocateExpenses_tr"+ExpenseId);
                        //jqueryDatatable();
                    }
                }
            });
        }

        
    </script>

    <script>
        $(function () {
            jqueryDatatable();

            setTimeout(function () {
                $($.fn.dataTable.tables(true)).DataTable().columns.adjust().draw();
            }, 200);
        });
        function jqueryDatatable() {
            $('#tblProgram').dataTable({
                bFilter: false,
                "scrollX": false,
                bSort: false,
                bLengthChange: false,
                paging: false,
                bInfo: false
            });

            $('#tblAllocatedExpenses').dataTable({
                // iDisplayLength: 100,
                destroy: true,
                bFilter: false,
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
                destroy: true,
                bFilter: false,
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
</asp:Content>

